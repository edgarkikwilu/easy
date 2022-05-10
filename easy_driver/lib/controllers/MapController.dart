import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:easy_driver/Helper/Constants.dart';
import 'package:easy_driver/Helper/colors.dart';
import 'package:easy_driver/Helper/helper.dart';
import 'package:easy_driver/models/Delivery.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class MapController extends GetxController{
  final Completer<GoogleMapController> _googleMapController = Completer();
  CameraPosition _cameraPosition = const CameraPosition(target: LatLng(-6.776012,39.178326),zoom: 14.4746);

  Set<Marker> _markers = HashSet<Marker>();
  Map<PolylineId, Polyline> _polylines = {};
  PolylinePoints polylinePoints = PolylinePoints();
  List<LatLng> polylineCoordinates = [];

  int markerIdCounter = 1;
  bool _isLoading = false;
  bool _driverConfirmed = false;
  bool _rideConfirmed = false;

  late Location _location;
  late LocationData _locationData;
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late Delivery _delivery;

  late BitmapDescriptor pickupIcon;
  late BitmapDescriptor destinationIcon;
  late BitmapDescriptor driverIcon;

  CameraPosition getCameraPosition() => _cameraPosition;
  Completer getGoogleMapController() => _googleMapController;

  Set<Marker> getMarkers() => _markers;
  Map<PolylineId,Polyline> getPolyline() => _polylines;

  bool getIsLoading() => _isLoading;
  bool getDriverConfirmed() => _driverConfirmed;
  bool getRideConfirmed() => _rideConfirmed;

  @override
  void onInit(){
    super.onInit();
    BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(devicePixelRatio: 1.5),
      'assets/images/pickup.png'
    ).then((value) => pickupIcon = value);

    BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/destination.png'
    ).then((value) => destinationIcon = value);

    BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/ic_car.png'
    ).then((value) => driverIcon = value);

    _initUserLocationService();
  }

  _initUserLocationService()async{
    _location = Location();
    _location.enableBackgroundMode(enable: true);

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await _location.getLocation();
    print("printing user location");
    print(_locationData.heading);

    _location.onLocationChanged.listen((LocationData currentLocation) {
      print(currentLocation.accuracy);
      print(currentLocation.heading);
      print("${currentLocation.latitude},${currentLocation.longitude}");

      if(currentLocation.accuracy! < 20){
        setDriverLocation(currentLocation);
      }
    });
  }

  setCameraPosition(CameraPosition cameraPosition){
    _cameraPosition = cameraPosition;
    update(['map_page']);
  }

  setPolyline(Map<PolylineId,Polyline> polyline){
    _polylines = polyline;
    update(['map_page']);
  }

  setIsLoading(bool isLoading){
    _isLoading = isLoading;
    update(['ride-option-bottomsheet']);
  }
  setDriverConfirmed(bool driverConfirmed){
    _driverConfirmed = driverConfirmed;
    update(['map_page']);
  }
  setRideConfirmed(bool rideConfirmed){
    _rideConfirmed = rideConfirmed;
    update(['map_page']);
  }

  setPickupLocation(double lat,double lng){
    Marker marker = Marker(markerId: const MarkerId("pickup"),
      position: LatLng(lat,lng),
      icon: pickupIcon
    );
    _markers.add(marker);

    updateCameraPosition(LatLng(lat,lng),'pickup',11);
    update(['map_page']);
  }
  setDestinationLocation(double lat,double lng){
    Marker marker = Marker(markerId: const MarkerId("destination"),
      position: LatLng(lat,lng),
      icon: destinationIcon
    );
    _markers.add(marker);
    updateCameraPosition(LatLng(lat,lng),'destination',11);
    _getPolyline();
    update(['map_page']);
  }

  updateCameraPosition(LatLng position,String type,double zoom)async{
    CameraPosition newPosition = CameraPosition(target: LatLng(position.latitude,position.longitude),zoom: zoom);
    final GoogleMapController controller = await _googleMapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(newPosition));

    Marker pickupMarker = _markers.firstWhere((marker) => marker.markerId==const MarkerId("pickup"));
    Marker destinationMarker = _markers.firstWhere((marker) => marker.markerId==const MarkerId("destination"));
    controller.animateCamera(
        CameraUpdate.newLatLngBounds(
            LatLngBounds(southwest: pickupMarker.position,
                northeast: destinationMarker.position),
            50
        )
    );
  }

  Future<int> endDelivery() async{
    setIsLoading(true);
    update(['ride-option-bottomsheet','map_page']);
    await Future.delayed(const Duration(seconds: 2),(){
      setRideConfirmed(false);
      setDriverConfirmed(false);
      markerIdCounter = 1;
      // _markers.clear();
      _markers.removeWhere((element) => element.markerId==const MarkerId("destination"));
      _markers.removeWhere((element) => element.markerId==const MarkerId("driver"));
      _polylines = <PolylineId,Polyline>{};

      setIsLoading(false);

      update(['map_page','ride-option-bottomsheet','location-bottomsheet']);
    });
    return 200;
  }


  updateLocation(String type, Location location){

  }

  _addPolyLine() {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(width: 8,
        polylineId: id, color: AppColor.orange, points: polylineCoordinates);
    _polylines[id] = polyline;
    update(['map_page']);
  }

  _getPolyline() async {
    Marker pickupMarker = _markers.firstWhere((marker) => marker.markerId==const MarkerId("pickup"));
    Marker destinationMarker = _markers.firstWhere((marker) => marker.markerId==const MarkerId("destination"));

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        Constants.googleMapApiKey,
        PointLatLng(pickupMarker.position.latitude,pickupMarker.position.longitude),
        PointLatLng(destinationMarker.position.latitude,destinationMarker.position.longitude),
        travelMode: TravelMode.driving,
        wayPoints: [PolylineWayPoint(location: "")]);
    if (result.points.isNotEmpty) {
      polylineCoordinates.clear();
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    _addPolyLine();
  }
  
  Future<LatLng> _snapToRoad() async{

    var response = await http.get(Uri.parse("https://roads.googleapis.com/v1/snapToRoads?"
        "path=${_locationData.latitude},${_locationData.longitude}&key=${Constants.googleMapApiKey}"),
      headers: Helper.getHeaders()
    );
    late LatLng point;
    print(response.statusCode);
    print(response.body);
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      final snappedLocation = data['snappedPoints'][0]['location'];
      point =  LatLng(snappedLocation['latitude'],snappedLocation['longitude']);
      print(point);
    }
    return point;
  }

  setDriverLocation(LocationData locationData) async{

    // LatLng snappedLocation = await _snapToRoad();
    LatLng snappedLocation = LatLng(locationData.latitude!, locationData.longitude!);

    _markers.removeWhere((marker) => marker.markerId==const MarkerId('driver'));

    Marker marker = Marker(markerId: const MarkerId("driver"),
        position: LatLng(snappedLocation.latitude,snappedLocation.longitude),
        icon: driverIcon,rotation: locationData.heading!
    );
    _markers.add(marker);

    updateCameraPosition(LatLng(snappedLocation.latitude,snappedLocation.longitude),'driver',13);
    // _getPolyline();
    update(['map_page']);
  }


}