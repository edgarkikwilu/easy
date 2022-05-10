import 'package:easy_client/Helper/CustomTheme.dart';
import 'package:easy_client/controllers/ProfileController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileLanding extends StatelessWidget{
  ProfileLanding({Key? key}) : super(key: key);

  final ProfileController _profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      id: 'profile_landing',
      builder: (controller)=>Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Edgar Kikwilu",style: Theme.of(context).textTheme.headline6),
                      Text("Help",style: Theme.of(context).textTheme.button!.apply(color: CustomColors.primary))
                    ],
                  ),
                  const SizedBox(height: 50),
                  Text("Your Account",style: Theme.of(context).textTheme.subtitle2),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: (){

                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Icon(Icons.person_outline_sharp,color: Colors.blueGrey)
                        ),
                        Expanded(
                            flex: 8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Personal Information",style: Theme.of(context).textTheme.bodyText1),
                                Text("+255 656 724 750",style: Theme.of(context).textTheme.caption),
                              ],
                            )
                        ),
                        const Expanded(
                            flex: 1,
                            child: Icon(Icons.chevron_right_sharp)
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: (){

                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Expanded(
                            flex: 1,
                            child: Icon(Icons.credit_card,color: Colors.blueGrey)
                        ),
                        Expanded(
                            flex: 8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Card And Account",style: Theme.of(context).textTheme.bodyText1),
                              ],
                            )
                        ),
                        const Expanded(
                            flex: 1,
                            child: Icon(Icons.chevron_right_sharp)
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: (){

                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Expanded(
                            flex: 1,
                            child: Icon(Icons.location_pin,color: Colors.blueGrey)
                        ),
                        Expanded(
                            flex: 8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Places And Addresses",style: Theme.of(context).textTheme.bodyText1),
                              ],
                            )
                        ),
                        const Expanded(
                            flex: 1,
                            child: Icon(Icons.chevron_right_sharp)
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: (){

                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Expanded(
                            flex: 1,
                            child: Icon(Icons.access_time_sharp,color: Colors.blueGrey)
                        ),
                        Expanded(
                            flex: 8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Your Activities",style: Theme.of(context).textTheme.bodyText1),
                              ],
                            )
                        ),
                        const Expanded(
                            flex: 1,
                            child: Icon(Icons.chevron_right_sharp)
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: (){

                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Expanded(
                            flex: 1,
                            child: Icon(Icons.notifications_none_sharp,color: Colors.blueGrey)
                        ),
                        Expanded(
                            flex: 8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Notifications",style: Theme.of(context).textTheme.bodyText1),
                              ],
                            )
                        ),
                        const Expanded(
                            flex: 1,
                            child: Icon(Icons.chevron_right_sharp)
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: (){

                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Expanded(
                            flex: 1,
                            child: Icon(Icons.business_center_sharp,color: Colors.blueGrey)
                        ),
                        Expanded(
                            flex: 8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Manage Business Profile",style: Theme.of(context).textTheme.bodyText1),
                              ],
                            )
                        ),
                        const Expanded(
                            flex: 1,
                            child: Icon(Icons.chevron_right_sharp)
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  Text("Benefits",style: Theme.of(context).textTheme.subtitle2),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: (){

                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Expanded(
                            flex: 1,
                            child: Icon(Icons.business_center_sharp,color: Colors.blueGrey)
                        ),
                        Expanded(
                            flex: 8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Rewards",style: Theme.of(context).textTheme.bodyText1),
                                Text("Make a transaction to earn profits",style: Theme.of(context).textTheme.caption),
                              ],
                            )
                        ),
                        const Expanded(
                            flex: 1,
                            child: Icon(Icons.chevron_right_sharp)
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  Text("Support",style: Theme.of(context).textTheme.subtitle2),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: (){

                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Expanded(
                            flex: 1,
                            child: Icon(Icons.business_center_sharp,color: Colors.blueGrey)
                        ),
                        Expanded(
                            flex: 8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Language",style: Theme.of(context).textTheme.bodyText1),
                                Text("English Selected. Click to change",style: Theme.of(context).textTheme.caption),
                              ],
                            )
                        ),
                        const Expanded(
                            flex: 1,
                            child: Icon(Icons.chevron_right_sharp)
                        )
                      ],
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