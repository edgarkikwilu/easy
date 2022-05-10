import 'package:easy_driver/Helper/CustomTheme.dart';
import 'package:easy_driver/controllers/AccountController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LicenseIdentificationPage extends StatelessWidget{
  const LicenseIdentificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(
      id: 'license-page',
      builder: (controller)=>Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text("Personal Information",style: Theme.of(context).textTheme.subtitle2),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Text("Driver's License",style: Theme.of(context).textTheme.bodyText2),
                  const SizedBox(height: 10),
                  Text("Driver's license number is required if driver has a car "
                      "if you are delivering a bicycle these fields can be left blank",
                      style: Theme.of(context).textTheme.caption!.copyWith(color: CustomColors.someGray)),
                  const SizedBox(height: 30),
                  Text("License Number",style: Theme.of(context).textTheme.bodyText2),
                  const SizedBox(height: 10),
                  TextFormField(
                    enabled: false,
                    controller: controller.licenseNumberController,
                    decoration: InputDecoration(
                        fillColor: CustomColors.white,
                        filled: true,
                        prefixIcon: const Icon(Icons.badge_outlined),
                        contentPadding: const EdgeInsets.only(left: 40),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(color: CustomColors.gray,width: 1)
                        )
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}