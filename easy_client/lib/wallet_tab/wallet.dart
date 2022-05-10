import 'package:easy_client/Helper/CustomTheme.dart';
import 'package:easy_client/Helper/helper.dart';
import 'package:easy_client/controllers/WalletController.dart';
import 'package:easy_client/wallet_tab/add_wallet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletPage extends StatelessWidget{
  WalletPage({Key? key}) : super(key: key);

  final WalletController _walletController = Get.put(WalletController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletController>(
      id: 'wallet-page',
      builder: (controller)=>Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColors.white,
          actions: [
            TextButton(
              onPressed: (){

              },
              child: Text("Help",style: Theme.of(context).textTheme.button!.copyWith(color: Colors.black,fontWeight: FontWeight.w600))
            )
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Expanded(
                    flex: 5,
                      child: SingleChildScrollView(
                        child: Container(
                    decoration: BoxDecoration(
                          color: CustomColors.white
                    ),
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Column(
                        children: [
                          Center(
                            child: Text("Tsh 0",style: Theme.of(context).textTheme.headline4!.copyWith(color: CustomColors.dark,fontWeight: FontWeight.w900)),
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: Text("Available credit",style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 16,fontWeight: FontWeight.w600)),
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      Get.to(()=>const AddWallet());
                                    },
                                    child: Container(
                                      child: Image.asset(Helper.getAssetName("wallet.png", "images"),height: 50,fit: BoxFit.contain),
                                      decoration: BoxDecoration(
                                          color: CustomColors.gray,
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      height: 90,
                                      width: 80,
                                      padding: const EdgeInsets.all(12),
                                    ),
                                  ),
                                  Text("Add",style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 16,fontWeight: FontWeight.w800))
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    child: Image.asset(Helper.getAssetName("send-money.png", "images"),height: 50,fit: BoxFit.contain),
                                    decoration: BoxDecoration(
                                        color: CustomColors.gray,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    height: 90,
                                    width: 80,
                                    padding: const EdgeInsets.all(12),
                                  ),
                                  Text("Send",style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 16,fontWeight: FontWeight.w800))
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    child: Image.asset(Helper.getAssetName("request.png", "images"),height: 50,fit: BoxFit.contain),
                                    decoration: BoxDecoration(
                                        color: CustomColors.gray,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    height: 90,
                                    width: 80,
                                    padding: const EdgeInsets.all(12),
                                  ),
                                  Text("Request",style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 16,fontWeight: FontWeight.w800))
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 40),
                          GestureDetector(
                            onTap: (){

                            },
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: CircleAvatar(
                                      backgroundColor: CustomColors.primary.withOpacity(0.2),
                                      radius: 24,
                                      child: Image.asset(Helper.getAssetName("credit-card.png", "images"),height: 30,width: 30,fit: BoxFit.contain),
                                    )
                                ),
                                Expanded(
                                    flex: 6,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Card and accounts",style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 16,fontWeight: FontWeight.w600)),
                                        Text("All your payment methods in one place",style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 11,fontWeight: FontWeight.w600))
                                      ],
                                    )
                                ),
                                Expanded(
                                    flex: 2,
                                    child: Icon(Icons.chevron_right,color: CustomColors.someGray)
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: (){

                            },
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: CircleAvatar(
                                      backgroundColor: CustomColors.primary.withOpacity(0.2),
                                      radius: 24,
                                      child: Image.asset(Helper.getAssetName("schedule.png", "images"),height: 30,width: 30,fit: BoxFit.contain),
                                    )
                                ),
                                Expanded(
                                    flex: 6,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Upcoming and scheduled",style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 16,fontWeight: FontWeight.w600)),
                                        Text("Set up and manage all your transfers",style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 11,fontWeight: FontWeight.w600))
                                      ],
                                    )
                                ),
                                Expanded(
                                    flex: 2,
                                    child: Icon(Icons.chevron_right,color: CustomColors.someGray)
                                )
                              ],
                            ),
                          ),
                          Container(
                            color: CustomColors.gray,
                            height: 10,
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(top: 20),
                          ),
                        ],
                    ),
                  ),
                      )),
                  // Expanded(flex:1,child: const SizedBox(height: 10)),
                  Expanded(
                    flex: 4,
                    child: Container(
                    color: CustomColors.white,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 80),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: CustomColors.white,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(width: 4,color: CustomColors.gray)
                          ),
                          child: Image.asset(Helper.getAssetName("calculator.png", "images"),height: 50,width: 50,fit: BoxFit.contain),
                        ),
                        const SizedBox(height: 10),
                        Text("You have not made any transactions yet",style: Theme.of(context).textTheme.headline6!.
                        copyWith(fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center
                        ),
                        const SizedBox(height: 10),
                        Text("Any transactions you make will show here.",style: Theme.of(context).textTheme.caption!.
                        copyWith(fontWeight: FontWeight.w400),
                            textAlign: TextAlign.center
                        )
                      ],
                    ),
                  ))
                ],
              ),
            )
          )
        ),
      )
    );
  }

}