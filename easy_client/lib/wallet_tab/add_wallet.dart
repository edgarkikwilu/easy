import 'package:easy_client/Helper/CustomTheme.dart';
import 'package:easy_client/controllers/WalletController.dart';
import 'package:easy_client/reusable/WalletTransactionCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddWallet extends StatelessWidget{
  const AddWallet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletController>(
      builder:(controller)=>Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          // elevation: 0,
          centerTitle: true,
          title: Text("Wallet",style: Theme.of(context).textTheme.subtitle2!
              .copyWith(color: CustomColors.dark)),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(top: 20,left: 20,right: 20),
                  decoration: BoxDecoration(
                    color: CustomColors.white,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Total Balance",style: Theme.of(context).textTheme.subtitle1!.copyWith(color: CustomColors.dark,fontWeight: FontWeight.w500)),
                      Text("Tsh 23,000",style: Theme.of(context).textTheme.headline4!.copyWith(color: CustomColors.dark)),
                      Text("Updated last at: Tuesday, January 2 2022",style: Theme.of(context).textTheme.caption)
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width-20,
                  height: 50,
                  margin: const EdgeInsets.only(top: 20,left: 20,right: 20),
                  child: ElevatedButton(
                    onPressed: (){

                    },
                    child: Text("Top up Wallet", style: Theme.of(context).textTheme.button!.copyWith(color: CustomColors.white,fontSize: 18)),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 20,bottom: 20),
                  child: Text("Wallet Transactions", style: Theme.of(context).textTheme.button!.copyWith(color: CustomColors.dark,fontSize: 18)),
                ),
                SingleChildScrollView(
                  // height: 130,
                  child: ListView.builder(
                    itemCount: 5,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context,index){
                      return const WalletTransactionCard();
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