import 'package:easy_driver/tabs/AccountTab/LicenseIdentificationPage.dart';
import 'package:easy_driver/tabs/AccountTab/PersonalInfomation.dart';
import 'package:easy_driver/Helper/CustomTheme.dart';
import 'package:easy_driver/controllers/AccountController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountHomePage extends StatelessWidget{
  const AccountHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(
      id: 'account-home',
      builder: (controller)=>Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Profile",style: Theme.of(context).textTheme.subtitle2),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: CircleAvatar(
                          radius: 52,
                          backgroundColor: CustomColors.someGray,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: CustomColors.gray,
                            child: const Icon(Icons.person_outlined,size: 42,),
                          )
                      ),
                    ),
                    // Positioned(
                    //   right: 0,
                    //   bottom: 0,
                    //   child: Icon(Icons.photo_camera_outlined,size: 32,color: CustomColors.someGray)
                    // )
                  ],
                ),
                const SizedBox(height: 20),
                Text("Edgar Kikwilu", style: Theme.of(context).textTheme.subtitle1),
                const SizedBox(height: 40),
                GestureDetector(
                  onTap: (){
                    Get.to(()=>const PersonalInformation());
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                    decoration: BoxDecoration(
                      color: CustomColors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: CustomColors.gray)
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Icon(Icons.assignment_ind_outlined)
                        ),
                        Expanded(
                            flex: 7,
                            child: Text("Personal Information", style: Theme.of(context).textTheme.bodyText2!
                                .copyWith(fontWeight: FontWeight.w400,color: CustomColors.dark))
                        ),
                        const Expanded(
                            flex: 2,
                            child: Icon(Icons.east_outlined)
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: (){
                    Get.to(()=>const LicenseIdentificationPage());
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                    decoration: BoxDecoration(
                        color: CustomColors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: CustomColors.gray)
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                            flex: 1,
                            child: Icon(Icons.badge_outlined)
                        ),
                        Expanded(
                            flex: 7,
                            child: Text("Drivers License", style: Theme.of(context).textTheme.bodyText2!
                                .copyWith(fontWeight: FontWeight.w400,color: CustomColors.dark))
                        ),
                        const Expanded(
                            flex: 2,
                            child: Icon(Icons.east_outlined)
                        )
                      ],
                    ),
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