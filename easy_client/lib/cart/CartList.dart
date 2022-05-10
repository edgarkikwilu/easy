import 'package:easy_client/Helper/colors.dart';
import 'package:easy_client/Helper/helper.dart';
import 'package:easy_client/cart/checkoutScreen.dart';
import 'package:easy_client/controllers/CheckoutController.dart';
import 'package:easy_client/models/Cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartList extends StatelessWidget{
  const CartList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckoutController>(
      id: 'cart-screen',
      builder: (controller){
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: true,
            title: Text("Cart"),
            centerTitle: true,
            foregroundColor: Colors.black,
            backgroundColor: AppColor.placeholderBg,
            actions: [
              Visibility(
                visible: !controller.getIsClearingCart(),
                child: IconButton(onPressed: ()async{
                  controller.setIsClearingCart(true);
                  await controller.clearCart();
                  controller.setIsClearingCart(false);
                }, icon: const Icon(Icons.delete_forever_outlined),color: AppColor.orange),
              ),
              Visibility(
                  visible: controller.getIsClearingCart(),
                child: Center(child: Text("loading..",style: Theme.of(context).textTheme.caption))
              )
            ],
          ),
          body: FutureBuilder<List<Cart>>(
            future: controller.loadCart(),
            builder: (context,snapShot){
              if(snapShot.hasError){
                print(snapShot.error);
                return const Center(
                  child: Text("Error loading cart")
                );
              }
              if(snapShot.connectionState == ConnectionState.done && snapShot.data!.isEmpty){
                return const Center(
                  child: Text("Cart is empty")
                );
              }
              if(snapShot.connectionState == ConnectionState.done && snapShot.data!.isNotEmpty){
                return SafeArea(
                    child: SingleChildScrollView(
                      child: Container(
                          padding: const EdgeInsets.only(top: 20,bottom: 80),
                          height: MediaQuery.of(context).size.height,
                          child: Stack(
                            children: [
                              ListView.builder(
                                  itemCount: snapShot.data!.length,
                                  itemBuilder: (context,index){
                                    final cart = snapShot.data!.elementAt(index);
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 10,left: 10,right: 10),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Image.asset(Helper.getAssetName("hamburger2.jpg", "real"),height: 100,fit: BoxFit.cover)
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(cart.product.name, style: Theme.of(context).textTheme.subtitle2!.copyWith(color: Colors.black)),
                                                    // Text(cart.product.category.name, style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.grey)),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                            flex: 6,
                                                            child: Row(children: [
                                                              IconButton(onPressed: ()async{
                                                                await controller.updateCart('dec', cart);
                                                              }, icon: const Icon(Icons.chevron_left)),
                                                              Text("${cart.quantity}", style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.grey)),
                                                              IconButton(onPressed: ()async{
                                                                await controller.updateCart('inc', cart);
                                                              }, icon: const Icon(Icons.chevron_right))
                                                            ])
                                                        ),
                                                        Expanded(
                                                          flex: 4,
                                                          child: Text("Tsh ${cart.total}", style: Theme.of(context).textTheme.subtitle2!.copyWith(color: Colors.black)),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              )
                                          )
                                        ],
                                      ),
                                    );
                                  }
                              ),
                              Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 40,right: 40,top: 20,bottom: 20),
                                    decoration: const BoxDecoration(
                                        color: AppColor.placeholderBg
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Total", style: Theme.of(context).textTheme.subtitle2!.copyWith(color: Colors.black)),
                                            Text("Tsh ${controller.total}", style: Theme.of(context).textTheme.subtitle2!.copyWith(color: Colors.black)),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width,
                                          child: ElevatedButton(onPressed: (){
                                            Get.to(()=>CheckoutScreen());
                                          }, child: const Text("Checkout")),
                                        )
                                      ],
                                    ),
                                  )
                              )
                            ],
                          )
                      ),
                    )
                );
              }
              return Center(
                child: CircularProgressIndicator(backgroundColor: AppColor.orange)
              );
            },
          ),
        );
      }
    );
  }
}