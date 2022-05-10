import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:easy_client/Helper/Constants.dart';
import 'package:easy_client/Helper/colors.dart';
import 'package:easy_client/Helper/helper.dart';
import 'package:easy_client/models/Address.dart';
import 'package:easy_client/models/UserLocation.dart';
import 'package:easy_client/models/RideInformation.dart';
import 'package:easy_client/models/RiderInformation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart' hide Location hide TravelMode hide PlacesAutocompleteResponse;
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class MapController extends GetxController{
  final Completer<GoogleMapController> _googleMapController = Completer();
  CameraPosition _cameraPosition = const CameraPosition(target: LatLng(-6.776012,39.178326),zoom: 14.4746);

  TextEditingController pickupLocationController = TextEditingController();
  TextEditingController destinationLocationController = TextEditingController();
  TextEditingController searchLocationController = TextEditingController();

  List<UserLocation> _locationHistory = [];

  Set<Marker> _markers = HashSet<Marker>();
  Map<PolylineId, Polyline> _polylines = {};
  PolylinePoints polylinePoints = PolylinePoints();
  List<LatLng> polylineCoordinates = [];

  int markerIdCounter = 1;
  bool _isLoading = false;
  bool _driverConfirmed = false;
  bool _rideConfirmed = false;
  late Address tempAddress;
  late Location _location;
  late LocationData _locationData;
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late UserLocation _pickupLocation;
  late UserLocation _destinationLocation;
  late UserLocation _driverLocation;
  late RideInformation _selectedRideInformation;
  late RiderInformation _selectedRiderInformation = RiderInformation.dummyRiderInfo();

  late BitmapDescriptor pickupIcon;
  late BitmapDescriptor destinationIcon;
  late BitmapDescriptor driverIcon;

  CameraPosition getCameraPosition() => _cameraPosition;
  Completer getGoogleMapController() => _googleMapController;
  List<UserLocation> getLocationHistory() => _locationHistory;
  UserLocation getPickupLocation() => _pickupLocation;
  UserLocation getDestinationLocation() => _destinationLocation;
  UserLocation getDriverLocation() => _driverLocation;
  Set<Marker> getMarkers() => _markers;
  Map<PolylineId,Polyline> getPolyline() => _polylines;
  RideInformation getSelectedRideInfomation() => _selectedRideInformation;
  RiderInformation getSelectedRiderInfomation() => _selectedRiderInformation;
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
    UserLocation userLocation = UserLocation("my location", _locationData.latitude!, _locationData.longitude!);
    setPickupLocation(userLocation);
  }

  setCameraPosition(CameraPosition cameraPosition){
    _cameraPosition = cameraPosition;
    update(['map_page']);
  }

  setSelectedRideInformation(RideInformation rideInformation){
    _selectedRideInformation = rideInformation;
    update(['ride-option-bottomsheet']);
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

  setPickupLocation(UserLocation location){
    _pickupLocation = location;
    pickupLocationController.text = location.name;
    Marker marker = Marker(markerId: const MarkerId("pickup"),
      position: LatLng(location.lat,location.lng),
      icon: pickupIcon
    );
    _markers.add(marker);

    updateCameraPosition(LatLng(location.lat,location.lng),'pickup',11);
    update(['map_page']);
  }
  setDestinationLocation(UserLocation location){
    _destinationLocation = location;
    destinationLocationController.text = location.name;
    Marker marker = Marker(markerId: const MarkerId("destination"),
      position: LatLng(location.lat,location.lng),
      icon: destinationIcon
    );
    _markers.add(marker);
    updateCameraPosition(LatLng(location.lat,location.lng),'destination',11);
    _getPolyline();
    update(['map_page']);
  }

  updateCameraPosition(LatLng position,String type,double zoom)async{
    CameraPosition newPosition = CameraPosition(target: LatLng(position.latitude,position.longitude),zoom: zoom);
    final GoogleMapController controller = await _googleMapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(newPosition));
    if(type=='destination'){
      controller.animateCamera(
          CameraUpdate.newLatLngBounds(
              LatLngBounds(southwest: LatLng(_pickupLocation.lat,_pickupLocation.lng),
                  northeast: LatLng(_destinationLocation.lat,_destinationLocation.lng)),
              50
          )
      );
    }
  }

  Future<RideInformation> loadRideInfo() async{
    late RideInformation rideInformation;
    await Future.delayed(const Duration(seconds: 2),(){
      rideInformation = RideInformation.dummyRideInfo();
      _selectedRideInformation = rideInformation;
    });
    return rideInformation;
  }

  Future<int> confirmRide() async{
    setIsLoading(true);
    update(['ride-option-bottomsheet']);
    late RiderInformation riderInformation;
    await Future.delayed(const Duration(seconds: 2),(){
      riderInformation = RiderInformation.dummyRiderInfo();
      _selectedRiderInformation = riderInformation;
      setIsLoading(false);
      UserLocation driverLocation = UserLocation("driver", -6.793970, 39.207161);
      setDriverLocation(driverLocation,90);
      update(['ride-option-bottomsheet','map_page']);
    });
    return 200;
  }

  Future<int> cancelRide() async{
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
      // pickupLocationController.clear();
      destinationLocationController.clear();
      setIsLoading(false);

      update(['map_page','ride-option-bottomsheet','location-bottomsheet']);
    });
    return 200;
  }

  Future<int> fetchRideDescription() async{
    var response = await http.post(Helper.parseUrl("ride/information"),
      body: jsonEncode(<String,dynamic>{
        "pickupLat":_pickupLocation.lat,
        "pickupLng":_pickupLocation.lng,
        "destinationLat":_destinationLocation.lat,
        "destinationLng":_destinationLocation.lng
      }),
      headers: Helper.getHeaders()
    );

    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      _selectedRideInformation = RideInformation.fromJson(data['ride_information']);
    }
    return response.statusCode;
  }

  Future<int> setLocation(String type,String place,BuildContext context) async{
    print('set location');
    var prediction = await PlacesAutocomplete.show(
      context: context,
      apiKey: Constants.googleMapApiKey,
      mode: Mode.fullscreen,
      language: 'en',
      offset: 0,
      radius: 10000,
      types: [],
      strictbounds: false,
      components: [],
      onError: onError
    );

    print(prediction);


    final places = GoogleMapsPlaces(apiKey: Constants.googleMapApiKey);
    PlacesDetailsResponse placesDetailsResponse = await places.getDetailsByPlaceId(prediction!.placeId!);
    if(placesDetailsResponse.isOkay){
      Address address = Address(prediction.distanceMeters, prediction.description,
          "${placesDetailsResponse.result.geometry!.location.lat}",
          "${placesDetailsResponse.result.geometry!.location.lng}", 0);
      // addresses.add(address);
      tempAddress = address;

      if(type=='pickup'){
        setPickupLocation(UserLocation("pickup", double.parse(address.lat!), double.parse(address.lng!)));
      }else if(type=='destination'){
        setDestinationLocation(UserLocation(prediction.description!, double.parse(address.lat!), double.parse(address.lng!)));
      }
      return 0;
    }
    return 1;
  }

  updateLocation(String type, Location location){

  }

  onError(error){
    print(error.errorMessage);
  }

   Future<List<UserLocation>> loadLocationHistory(String type) async{
    if(type == 'pickup') {
      _locationHistory = await UserLocation.initPickupLocation();
    } else {
      _locationHistory = await UserLocation.initDestinationLocation();
    }
    return _locationHistory;
  }

  _addPolyLine() {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(width: 8,
        polylineId: id, color: AppColor.orange, points: polylineCoordinates);
    _polylines[id] = polyline;
    update(['map_page']);
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        Constants.googleMapApiKey,
        PointLatLng(_pickupLocation.lat, _pickupLocation.lng),
        PointLatLng(_destinationLocation.lat,_destinationLocation.lng),
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
        "path=${_driverLocation.lat},${_driverLocation.lng}&key=${Constants.googleMapApiKey}"),
      headers: Helper.getHeaders()
    );
    late LatLng point;
    print(_driverLocation);
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

  setDriverLocation(UserLocation location,double rotation) async{
    _driverLocation = location;

    // LatLng snappedLocation = await _snapToRoad();
    LatLng snappedLocation = LatLng(location.lat, location.lng);

    _markers.removeWhere((marker) => marker.markerId==const MarkerId('driver'));

    Marker marker = Marker(markerId: const MarkerId("driver"),
        position: LatLng(snappedLocation.latitude,snappedLocation.longitude),
        icon: driverIcon,rotation: rotation
    );
    _markers.add(marker);

    updateCameraPosition(LatLng(location.lat,location.lng),'driver',13);
    // _getPolyline();
    update(['map_page']);
  }


}