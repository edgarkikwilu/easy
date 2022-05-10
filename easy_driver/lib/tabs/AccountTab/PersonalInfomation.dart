import 'package:easy_driver/Helper/CustomTheme.dart';
import 'package:easy_driver/controllers/AccountController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalInformation extends StatelessWidget{
  const PersonalInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(
      id:'personal-info-page',
      builder: (controller){
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: Text("Personal Information",style: Theme.of(context).textTheme.subtitle2),
            centerTitle: true,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    Text("Full Name",style: Theme.of(context).textTheme.bodyText2),
                    const SizedBox(height: 10),
                    TextFormField(
                      enabled: false,
                      controller: controller.userNameController,
                      decoration: InputDecoration(
                          fillColor: CustomColors.white,
                          filled: true,
                          prefixIcon: const Icon(Icons.person_outlined),
                          contentPadding: const EdgeInsets.only(left: 40),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: CustomColors.gray,width: 1)
                          )
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text("Phone Number",style: Theme.of(context).textTheme.bodyText2),
                    const SizedBox(height: 10),
                    TextFormField(
                      enabled: false,
                      controller: controller.phoneNumberController,
                      decoration: InputDecoration(
                          fillColor: CustomColors.white,
                          filled: true,
                          prefixIcon: const Icon(Icons.dialpad_outlined),
                          contentPadding: const EdgeInsets.only(left: 40),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: CustomColors.gray,width: 1)
                          )
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text("NIDA Number",style: Theme.of(context).textTheme.bodyText2),
                    const SizedBox(height: 10),
                    TextFormField(
                      enabled: false,
                      controller: controller.idController,
                      decoration: InputDecoration(
                          fillColor: CustomColors.white,
                          filled: true,
                          prefixIcon: const Icon(Icons.badge_outlined),
                          contentPadding: const EdgeInsets.only(left: 40),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: CustomColors.gray,width: 1)
                          )
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        );
      }
    );
  }
}