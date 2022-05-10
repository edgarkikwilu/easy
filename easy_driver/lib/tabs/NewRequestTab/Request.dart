import 'package:easy_driver/Helper/CustomTheme.dart';
import 'package:easy_driver/Helper/helper.dart';
import 'package:flutter/material.dart';

class RequestWidget extends StatelessWidget{
  final int _index;

  RequestWidget({required int index})
    :_index = index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: CustomColors.someGray,width: 1)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Deliver by 1:24 pm", style: Theme.of(context).textTheme.bodyText2!.copyWith(color: CustomColors.dark)),
              Text("$_index item", style: Theme.of(context).textTheme.bodyText2!.copyWith(color: CustomColors.dark))
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Monica's Tronitta", style: Theme.of(context).textTheme.subtitle1!.copyWith(color: CustomColors.dark)),
              Text("$_index km", style: Theme.of(context).textTheme.bodyText2!.copyWith(color: CustomColors.dark))
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Distance to restaurant", style: Theme.of(context).textTheme.bodyText2!.copyWith(color: CustomColors.dark)),
              Text("${_index/2.3} km", style: Theme.of(context).textTheme.bodyText2!.copyWith(color: CustomColors.dark))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Divider(thickness: 0.2, height: 40, color: CustomColors.someGray),
          ),
          Text("Tsh 45000",
              style: TextStyle(fontWeight: FontWeight.w900,color: CustomColors.dark)
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RotatedBox(
                quarterTurns: 2,
                child: Icon(Icons.navigation_outlined,color: CustomColors.red,size: 12),
              ),
              const SizedBox(width: 20),
              Text("King of meat, Masaki", style: Theme.of(context).textTheme.bodyText2!.copyWith(color: CustomColors.someGray))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.more_vert_outlined,color: CustomColors.red,size: 10),
              Divider(thickness: 1,color: CustomColors.primary,height: 10)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.fiber_manual_record_outlined,color: CustomColors.someGray,size: 12),
              const SizedBox(width: 20),
              Text("Kwa Mallya, Goba Centre, Dar es salaam", style: Theme.of(context).textTheme.bodyText2!.copyWith(color: CustomColors.someGray))
            ],
          ),
          const SizedBox(height: 20),
          ListView.builder(
            itemCount: 3,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context,index){
              return Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: CustomColors.someGray,width: 0.2),
                  borderRadius: BorderRadius.circular(10)
                ),
                
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: CustomColors.white,
                        child: Image.asset(Helper.getAssetName("ic_car.png", "images"),fit: BoxFit.fill,),
                      )
                    ),
                    Expanded(
                      flex: 7,
                      child: Text("Burger with cheese", style: Theme.of(context).textTheme.caption,maxLines: 2,softWrap: true,)
                    ),
                    Expanded(
                      flex: 2,
                      child: Text("x2", style: Theme.of(context).textTheme.caption)
                    )
                  ],
                ),
              );
            }
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: CustomColors.red),
                onPressed: (){

                },
                child: Text("Reject",style: Theme.of(context).textTheme.button!.copyWith(color: CustomColors.white))
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: CustomColors.primary),
                  onPressed: (){

                  },
                  child: Text("Accept",style: Theme.of(context).textTheme.button!.copyWith(color: CustomColors.white))
              )
            ],
          )
        ],
      ),
    );
  }
}