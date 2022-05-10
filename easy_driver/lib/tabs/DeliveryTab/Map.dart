import 'package:easy_driver/Helper/CustomTheme.dart';
import 'package:easy_driver/Helper/colors.dart';
import 'package:easy_driver/controllers/MapController.dart';
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
                       children: const [
                         Text("Michungwani, Kimara Mwisho, Dar es salaam"),
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
                       color: AppColor.placeholder
                     ),
                     child: Column(
                       children: [
                         const SizedBox(height: 16),
                         Text("Your Customer",style: Theme.of(context).textTheme.bodyText2),
                         Row(
                           mainAxisSize: MainAxisSize.min,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             const SizedBox(width: 20),
                             Expanded(
                                 flex: 2,
                                 child: CircleAvatar(
                                   radius: 45, backgroundColor: AppColor.placeholder,
                                   child: Image.network("https://gravatar.com/avatar/5ebdfff3afb1607f45cd55c7733ea0ec?s=400&d=robohash&r=x",height: 50,width: 50,),
                                 )
                             ),
                             const SizedBox(width: 20),
                             Expanded(
                                 flex: 3,
                                 child: Column(
                                   mainAxisSize: MainAxisSize.min,
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Text("Edgar Kikwilu", style: Theme.of(context).textTheme.subtitle2),
                                     Text("0763 006 587", style: Theme.of(context).textTheme.button),
                                   ],
                                 )
                             ),
                             Expanded(
                                 flex: 5,
                                 child: Column(
                                   mainAxisSize: MainAxisSize.min,
                                   crossAxisAlignment: CrossAxisAlignment.end,
                                   children: [
                                     ElevatedButton(onPressed: (){},
                                       child: Text("Call", style: Theme.of(context).textTheme.subtitle2),
                                     ),
                                     ElevatedButton(onPressed: (){},
                                       child: Text("Message", style: Theme.of(context).textTheme.subtitle2),
                                     )
                                   ],
                                 )
                             ),
                             const SizedBox(width: 20),
                           ],
                         ),
                         const SizedBox(height: 20),
                         Visibility(
                           visible: !_mapController.getIsLoading(),
                           child: SizedBox(
                             width:MediaQuery.of(context).size.width-20,
                             child: ElevatedButton(
                               onPressed: () async{

                               },
                               child: Text("Start Delivery",style: Theme.of(context).textTheme.button!.copyWith(color: Colors.white)),
                             ),
                           ),
                         ),
                         Visibility(
                             visible: _mapController.getIsLoading(),
                             child: const Center(
                               child: CircularProgressIndicator(backgroundColor: AppColor.orange),
                             )
                         ),
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
}