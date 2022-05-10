import 'dart:math';

import 'package:easy_client/Helper/CustomTheme.dart';
import 'package:easy_client/Helper/colors.dart';
import 'package:easy_client/Helper/helper.dart';
import 'package:easy_client/controllers/MapController.dart';
import 'package:easy_client/models/UserLocation.dart';
import 'package:easy_client/models/RideInformation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatelessWidget{
  final MapController _mapController = Get.find();
  MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapController>(
      id: 'map_page',
      builder: (_)=>Scaffold(
       body: SizedBox(
         width: MediaQuery.of(context).size.width,
         height: MediaQuery.of(context).size.height,
         child: Stack(
           alignment: Alignment.center,
           children: [
             GoogleMap(
               initialCameraPosition: _mapController.getCameraPosition(),
               mapType: MapType.normal,
               markers: _mapController.getMarkers(),
               polylines: Set<Polyline>.of(_mapController.getPolyline().values),
               onMapCreated: (GoogleMapController googleMapController){
                 if(!_mapController.getGoogleMapController().isCompleted){
                   _mapController.getGoogleMapController().complete(googleMapController);
                 }
               },
             ),
             Positioned(
               top: 40,
               left: 16,
               child: IconButton(
                 onPressed: (){
                   Get.back();
                 },
                 icon: const Icon(Icons.chevron_left)
               )
             ),
             Positioned(
               bottom: 0,
               left: 0,
               right: 0,
               child: Visibility(
                 visible: !_mapController.getRideConfirmed(),
                 child: AnimatedContainer(
                   height: 250,
                   width: MediaQuery.of(context).size.width,
                   alignment: Alignment.center,
                   decoration: BoxDecoration(
                     color: CustomColors.white,
                     borderRadius: const BorderRadius.vertical(top: Radius.circular(23))
                   ),
                   duration: const Duration(milliseconds: 500),
                   child: Column(
                     mainAxisSize: MainAxisSize.min,
                     children: [
                       Text("Where you want to go",style: Theme.of(context).textTheme.button!.copyWith(fontWeight: FontWeight.w900)),
                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 20),
                         child: TextFormField(
                           controller: _mapController.pickupLocationController,
                           maxLines: 1,
                           decoration: const InputDecoration(border: UnderlineInputBorder(),labelText: "Pickup location"),
                           onTap: (){
                             showLocationBottomSheet(context,'pickup');
                           },
                         ),
                       ),
                       const SizedBox(height: 12),
                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 20),
                         child: TextFormField(
                           controller: _mapController.destinationLocationController,
                           maxLines: 1,
                           decoration: const InputDecoration(border: UnderlineInputBorder(),labelText: "Destination location"),
                           onTap: (){
                             showLocationBottomSheet(context,'destination');
                           },
                         ),
                       )
                     ],
                   ),
                 ),
               )
             ),
             Positioned(
                 top: 90,
                 left: 16,
                 right: 16,
                 child: Visibility(
                   visible: _mapController.getRideConfirmed(),
                   child: AnimatedContainer(
                     height: 78,
                     width: MediaQuery.of(context).size.width-20,
                     padding: const EdgeInsets.symmetric(horizontal: 20),
                     alignment: Alignment.center,
                     decoration: BoxDecoration(
                         color: CustomColors.white.withOpacity(0.4),
                         borderRadius: BorderRadius.circular(10)
                     ),
                     duration: const Duration(milliseconds: 500),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       mainAxisSize: MainAxisSize.min,
                       children: [
                         Text(_mapController.pickupLocationController.text),
                         const SizedBox(height: 20),
                         Text(_mapController.destinationLocationController.text)
                       ],
                     ),
                   ),
                 )
             ),
             Positioned(
                 bottom: 0,
                 left: 0,
                 child: Visibility(
                   visible: _mapController.getDriverConfirmed(),
                   child: Container(
                     width: MediaQuery.of(context).size.width,
                     height: 260,
                     decoration: const BoxDecoration(
                       color: AppColor.placeholderBg
                     ),
                     child: Column(
                       children: [
                         const SizedBox(height: 16),
                         Text("Your driver",style: Theme.of(context).textTheme.bodyText2),
                         Row(
                           mainAxisSize: MainAxisSize.min,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             const SizedBox(width: 20),
                             Expanded(
                                 flex: 2,
                                 child: CircleAvatar(
                                   radius: 45, backgroundColor: AppColor.placeholder,
                                   child: Image.network(_mapController.getSelectedRiderInfomation().avatar,height: 50,width: 50,),
                                 )
                             ),
                             const SizedBox(width: 20),
                             Expanded(
                                 flex: 3,
                                 child: Column(
                                   mainAxisSize: MainAxisSize.min,
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Text(_mapController.getSelectedRiderInfomation().name, style: Theme.of(context).textTheme.subtitle2),
                                     Text(_mapController.getSelectedRiderInfomation().car, style: Theme.of(context).textTheme.button),
                                   ],
                                 )
                             ),
                             Expanded(
                                 flex: 5,
                                 child: Column(
                                   mainAxisSize: MainAxisSize.min,
                                   crossAxisAlignment: CrossAxisAlignment.end,
                                   children: [
                                     Text("Trips ${_mapController.getSelectedRiderInfomation().completedTrips}", style: Theme.of(context).textTheme.subtitle1),
                                     Text("Rating ${_mapController.getSelectedRiderInfomation().rating}/5", style: Theme.of(context).textTheme.caption),
                                   ],
                                 )
                             ),
                             const SizedBox(width: 20),
                           ],
                         ),
                         Text("Driver is on the way",style: Theme.of(context).textTheme.bodyText2),
                         const SizedBox(height: 20),
                         Visibility(
                           visible: !_mapController.getIsLoading(),
                           child: SizedBox(
                             width:MediaQuery.of(context).size.width-20,
                             child: ElevatedButton(
                               onPressed: () async{
                                 int code = await _mapController.cancelRide();
                                 if(code == 200){

                                 }
                               },
                               child: Text("Cancel Ride",style: Theme.of(context).textTheme.button!.copyWith(color: Colors.white)),
                             ),
                           ),
                         ),
                         Visibility(
                             visible: _mapController.getIsLoading(),
                             child: const Center(
                               child: CircularProgressIndicator(backgroundColor: AppColor.orange),
                             )
                         ),
                         SizedBox(
                           width:MediaQuery.of(context).size.width-20,
                           child: ElevatedButton(
                             onPressed: () async{
                               var random = Random();
                               int min = 0;
                               int max = UserLocation.initPickupLocation().length-1;
                               int result = min + random.nextInt(max - min);

                               int code = await _mapController.setDriverLocation(UserLocation.initPickupLocation().elementAt(result),result*90);
                               if(code == 200){

                               }
                             },
                             child: Text("Update Driver Location",style: Theme.of(context).textTheme.button!.copyWith(color: Colors.white)),
                           ),
                         )
                       ],
                     ),
                   ),
                 )
             )
           ],
         ),
       ),
      )
    );
  }

  showLocationBottomSheet(BuildContext context,String type){
    showModalBottomSheet(
      context: context,
      builder: (context){
        return GetBuilder<MapController>(
          id: 'location-bottomsheet',
          builder:(controller)=> Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Select $type location",style: Theme.of(context).textTheme.subtitle1),
                const SizedBox(height: 50),
                TextFormField(
                  onTap: ()async{
                    if(type=='pickup'){
                      await _mapController.setLocation("pickup", "", context);
                      Navigator.pop(context);
                      FocusScope.of(context).unfocus();
                    }else{
                      await _mapController.setLocation("destination", "", context);
                      Navigator.pop(context);
                      FocusScope.of(context).unfocus();
                      showRideOptionBottomSheet(context);
                    }
                  },
                  decoration: InputDecoration(
                    fillColor: CustomColors.gray,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none
                    ),
                    labelText: "Search location",
                    prefixIcon: const Icon(Icons.search)
                  ),
                ),
                const SizedBox(height: 20),
                FutureBuilder<List<UserLocation>>(
                  future: controller.loadLocationHistory(type),
                  builder: (context,snapShot){
                    if(snapShot.hasError){
                      return Center(
                        child: Text("Could not fetch location history", style: Theme.of(context).textTheme.subtitle2),
                      );
                    }
                    if(snapShot.hasData && snapShot.data!.length > 1){
                      return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.getLocationHistory().length,
                        itemBuilder: (context,index){
                          return GestureDetector(
                            onTap: (){
                              print(type);
                              Navigator.pop(context);
                              if(type=='pickup'){
                                controller.setPickupLocation(snapShot.data!.elementAt(index));
                              }else if(type=='destination'){
                                controller.setDestinationLocation(snapShot.data!.elementAt(index));
                                showRideOptionBottomSheet(context);
                              }
                            },
                            child: SizedBox(
                              height: 40,
                              child: Text(snapShot.data!.elementAt(index).name, style: Theme.of(context).textTheme.headline6)
                            ),
                          );
                        }
                      );
                    }
                    if(snapShot.hasData && snapShot.data!.isEmpty){
                      return Center(
                        child: Text("You currently dont have location history", style: Theme.of(context).textTheme.subtitle2),
                      );
                    }
                    return const CircularProgressIndicator();
                  }
                )
              ],
            ),
          ),
        );
      }
    );
  }

  showRideOptionBottomSheet(BuildContext context){
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        isScrollControlled: false,
        builder: (context){
          return GetBuilder<MapController>(
            id: 'ride-option-bottomsheet',
            builder:(controller)=> Container(
              height: 330,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Select ride",style: Theme.of(context).textTheme.subtitle1),
                  const SizedBox(height: 50),
                  FutureBuilder<RideInformation>(
                      future: controller.loadRideInfo(),
                      builder: (context,snapShot){
                        if(snapShot.hasError){
                          return Center(
                            child: Text("Something went wrong", style: Theme.of(context).textTheme.subtitle2),
                          );
                        }
                        if(snapShot.hasData && snapShot.data != null){
                          return GestureDetector(
                            onTap: (){
                              controller.setSelectedRideInformation(snapShot.data!);
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: controller.getSelectedRideInfomation() == snapShot.data?AppColor.orangeShade:Colors.white
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Image.asset(Helper.getAssetName("car_ride.png", "images"))
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          children: [
                                            Text("Car", style: Theme.of(context).textTheme.subtitle2),
                                            Text("1 min", style: Theme.of(context).textTheme.caption),
                                          ],
                                        )
                                      ),
                                      Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Text("3500 Tsh", style: Theme.of(context).textTheme.subtitle2),
                                              Text("5000 Tsh", style: Theme.of(context).textTheme.caption!.apply(decoration: TextDecoration.lineThrough)),
                                            ],
                                          )
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 40),
                                Visibility(
                                  visible: !controller.getIsLoading(),
                                  child: SizedBox(
                                    width:MediaQuery.of(context).size.width-20,
                                    child: ElevatedButton(
                                      onPressed: () async{
                                        int code = await controller.confirmRide();
                                        if(code == 200){
                                          Navigator.pop(context);
                                          controller.setDriverConfirmed(true);
                                          controller.setRideConfirmed(true);
                                        }
                                      },
                                      child: Text("Confirm Ride",style: Theme.of(context).textTheme.button!.copyWith(color: Colors.white)),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Visibility(
                                  visible: !controller.getIsLoading(),
                                  child: SizedBox(
                                    width:MediaQuery.of(context).size.width-20,
                                    child: TextButton(
                                      onPressed: () async{
                                        int code = await controller.cancelRide();
                                        if(code == 200){
                                          Navigator.pop(context);
                                          FocusScope.of(context).unfocus();
                                        }
                                      },
                                      child: Text("Cancel",style: Theme.of(context).textTheme.button!.copyWith(color: Colors.black)),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: controller.getIsLoading(),
                                  child: const Center(
                                    child: CircularProgressIndicator(backgroundColor: AppColor.orange),
                                  )
                                )
                              ],
                            ),
                          );
                        }
                        return const CircularProgressIndicator(backgroundColor: AppColor.orange);
                      }
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}