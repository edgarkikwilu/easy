import 'package:easy_driver/Helper/CustomTheme.dart';
import 'package:easy_driver/controllers/RequestController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestHistory extends StatelessWidget{
  const RequestHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RequestController>(
      id: 'request-history',
      builder: (controller)=>Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Orders History",style: Theme.of(context).textTheme.subtitle2),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Completed".toUpperCase(),style: Theme.of(context).textTheme.bodyText1!.copyWith(color: CustomColors.someGray,fontWeight: FontWeight.w100)),
                          const SizedBox(height: 10),
                          Text("231",style: Theme.of(context).textTheme.subtitle2!.copyWith(color: CustomColors.primary,fontWeight: FontWeight.w700)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Total".toUpperCase(),style: Theme.of(context).textTheme.bodyText1!.copyWith(color: CustomColors.someGray,fontWeight: FontWeight.w100)),
                          const SizedBox(height: 10),
                          Text("234",style: Theme.of(context).textTheme.subtitle2!.copyWith(color: CustomColors.dark,fontWeight: FontWeight.w700)),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text("Delivery History",
                    style: Theme.of(context).textTheme.subtitle2!
                        .copyWith(color: CustomColors.someGray),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: CustomColors.someGray,width: 0.2)
                  ),
                  child: ListView.builder(
                      itemCount: 3,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context,index){
                        return Container(
                          // height: 60,
                          padding: const EdgeInsets.only(bottom: 20,top: 10),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: index==2?CustomColors.gray:CustomColors.someGray,width: 0.2)
                            )
                          ),
                          child: Row(
                            children: [
                              const Expanded(
                                flex: 1,
                                child: Icon(Icons.local_shipping_outlined)
                              ),
                              Expanded(
                                flex: 7,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        RotatedBox(
                                          quarterTurns: 2,
                                          child: Icon(Icons.navigation_outlined,color: CustomColors.red,size: 12),
                                        ),
                                        const SizedBox(width: 4),
                                        Text("King of meat, Masaki",
                                            style: Theme.of(context).textTheme.bodyText2!
                                                .copyWith(color: CustomColors.someGray),
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(Icons.more_vert_outlined,color: CustomColors.red,size: 10),
                                        Divider(thickness: 1,color: CustomColors.someGray,height: 10)
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(Icons.fiber_manual_record_outlined,color: CustomColors.someGray,size: 12),
                                        const SizedBox(width: 4),
                                        Text("Kwa Mallya, Goba Centre, Dar es salaam",
                                          style: Theme.of(context).textTheme.bodyText2!
                                              .copyWith(color: CustomColors.someGray),
                                          overflow: TextOverflow.ellipsis,),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text("2 Jan, 2022", style: Theme.of(context).textTheme.bodyText2!.copyWith(color: CustomColors.someGray))
                              )
                            ],
                          ),
                        );
                      }
                  ),
                )
              ],
            ),
          )
        ),
      )
    );
  }
}