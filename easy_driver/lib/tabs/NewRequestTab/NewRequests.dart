import 'package:easy_driver/Helper/CustomTheme.dart';
import 'package:easy_driver/controllers/RequestController.dart';
import 'package:easy_driver/tabs/NewRequestTab/Request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewRequestPage extends StatelessWidget{
  const NewRequestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RequestController>(
      id: 'new-requests-page',
      builder: (controller)=>Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("New Order Requests",style: Theme.of(context).textTheme.subtitle2),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: FutureBuilder<int>(
              future: controller.loadNewRequests(),
              builder: (context,snapShot){
                if(snapShot.hasError){
                  return Center(
                    child: Text("Error loading new requests",style: Theme.of(context).textTheme.bodyText2),
                  );
                }
                if(snapShot.hasData && snapShot.connectionState == ConnectionState.done){
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapShot.data,
                      itemBuilder: (context,index){
                        return RequestWidget(index: index);
                      }
                    ),
                  );
                }
                return Center(
                  heightFactor: 20,
                  child: CircularProgressIndicator(color: CustomColors.primary),
                );
              },
            ),
          )
        )
      )
    );
  }
}