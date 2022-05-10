import 'package:easy_client/Helper/colors.dart';
import 'package:easy_client/Helper/helper.dart';
import 'package:easy_client/controllers/CheckoutController.dart';
import 'package:easy_client/models/Address.dart';
import 'package:edge_alerts/edge_alerts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeAddressScreen extends StatelessWidget {
  static const routeName = "/changeAddressScreen";

  const ChangeAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckoutController>(
      id: 'address-screen',
      builder:(controller)=> Scaffold(
        body: Stack(
          children: [
            SafeArea(
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.arrow_back_ios_rounded),
                      ),
                      Text(
                        "Change Address",
                        style: Helper.getTheme(context).headline5,
                      )
                    ],
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextFormField(
                      onTap: ()async{
                        int code = await controller.searchNewAddress(context);
                        if(code==0){
                          showSaveAddressDialog(context, controller.tempAddress);
                        }else{
                          edgeAlert(context,title: "Oops",description: "Something went wrong",
                              gravity:Gravity.top,duration: 2);
                        }
                      },
                      decoration: const InputDecoration(
                        hintText: "Search address",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.search)
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: ShapeDecoration(
                            shape: const CircleBorder(),
                            color: AppColor.orange.withOpacity(0.2),
                          ),
                          child: const Icon(
                            Icons.star_rounded,
                            color: AppColor.orange,
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            "Choose a saved place",
                            style: TextStyle(color: AppColor.primary),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  FutureBuilder<List<Address>>(
                    future: controller.loadAddresses(),
                    builder: (context,snapShot){
                      if(snapShot.hasError){
                        print(snapShot.error);
                        return Center(
                          heightFactor: 10,
                          child: Text("Error loading saved addresses",style: Theme.of(context).textTheme.subtitle2)
                        );
                      }
                      if(snapShot.connectionState==ConnectionState.done && snapShot.data!.isEmpty){
                        return Center(
                            heightFactor: 10,
                            child: Text("No saved address",style: Theme.of(context).textTheme.subtitle2)
                        );
                      }
                      if(snapShot.connectionState==ConnectionState.done && snapShot.data!.isNotEmpty){
                        return Container(
                          height: MediaQuery.of(context).size.height/2,
                          padding: const EdgeInsets.only(left: 30,right: 30,top: 50),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapShot.data!.length,
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context,index){
                              final address = snapShot.data!.elementAt(index);
                              return GestureDetector(
                                onTap: (){
                                  controller.setSelectedAddress(address);
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: 50,
                                  margin: const EdgeInsets.only(bottom: 20),
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.5),
                                    border: const Border(
                                      bottom: BorderSide(color: AppColor.orange)
                                    )
                                  ),
                                  child: Text("${address.name}",style: Theme.of(context).textTheme.subtitle2)
                                ),
                              );
                            }
                          ),
                        );
                      }
                      return const Center(
                        heightFactor: 10,
                        child: CircularProgressIndicator(color: AppColor.orange),
                      );
                    }
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  showSaveAddressDialog(BuildContext context,Address address){
    return showModalBottomSheet(
      context: context,
      builder: (context){
        return GetBuilder<CheckoutController>(
          id: 'save-address-dialog',
          builder:(controller)=> Container(
            height: 250,
            padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 20),
            child: Column(
              children: [
                Text("Save address?",style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.black)),
                Text("${address.name}",style: Theme.of(context).textTheme.caption),
                const SizedBox(height: 30),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () async{
                      await controller.addAddress(address);
                      Navigator.pop(context);
                    },
                    child: const Text("Save"),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: const Text("Select another location"),
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
