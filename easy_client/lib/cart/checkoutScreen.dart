import 'package:easy_client/Helper/colors.dart';
import 'package:easy_client/Helper/helper.dart';
import 'package:easy_client/cart/changeAddressScreen.dart';
import 'package:easy_client/controllers/CheckoutController.dart';
import 'package:easy_client/home.dart';
import 'package:easy_client/reusable/PaymentCard.dart';
import 'package:edge_alerts/edge_alerts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatelessWidget {
  static const routeName = "/checkoutScreen";

  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckoutController>(
      id: 'checkout-screen',
      builder:(controller)=> Scaffold(
        body: SafeArea(
          child: Column
            (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_rounded,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Checkout",
                      style: Helper.getTheme(context).headline5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text("Delivery Address"),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: Helper.getScreenWidth(context) * 0.4,
                      child: Text(
                        "${controller.selectedAddress==null?"Select delivery address":controller.selectedAddress.name}",
                        style: Helper.getTheme(context).headline3,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(()=>const ChangeAddressScreen());
                      },
                      child: const Text(
                        "Change",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 10,
                width: double.infinity,
                color: AppColor.placeholderBg,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Payment method"),
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  controller.setPaymentMethod('cash');
                },
                child: PaymentCard(
                  widget: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Cash on delivery"),
                      Container(
                        width: 15,
                        height: 15,
                        decoration: ShapeDecoration(
                            shape: const CircleBorder(
                              side: BorderSide(color: AppColor.orange),
                            ),
                            color: controller.getPaymentMethod()=='cash'?AppColor.orange:Colors.white.withOpacity(0.5)
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: (){
                  controller.setPaymentMethod('selcom');
                },
                child: PaymentCard(
                  widget: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 40,
                            height: 30,
                            child: Image.asset(Helper.getAssetName("paypal.png", "real")),
                          ),
                          const SizedBox(width: 10),
                          const Text("johndoe@email.com"),
                        ],
                      ),
                      Container(
                        width: 15,
                        height: 15,
                        decoration: ShapeDecoration(
                            shape: const CircleBorder(side: BorderSide(color: AppColor.orange)),
                            color: controller.getPaymentMethod()=='selcom'?AppColor.orange:Colors.white.withOpacity(0.5)
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 10,
                width: double.infinity,
                color: AppColor.placeholderBg,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Sub Total"),
                        Text(
                          "Tsh ${controller.total}",
                          style: Helper.getTheme(context).headline3,
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Delivery Cost"),
                        Text(
                          "Tsh 2000",
                          style: Helper.getTheme(context).headline3,
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Discount"),
                        Text("-Tsh 0", style: Helper.getTheme(context).headline3)
                      ],
                    ),
                    Divider(
                      height: 40,
                      color: AppColor.placeholder.withOpacity(0.25),
                      thickness: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Total"),
                        Text(
                          "Tsh ${controller.total + 2000}",
                          style: Helper.getTheme(context).headline3,
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              Container(
                height: 10,
                width: double.infinity,
                color: AppColor.placeholderBg,
              ),
              const SizedBox(height: 20),
              Visibility(
                visible: !controller.getIsLoading(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async{
                        if(controller.selectedAddress == null){
                          edgeAlert(context,title: "Delivery Address!",description: "Please select delivery address!",backgroundColor: AppColor.orange,
                              icon: Icons.check_circle_outline_outlined, gravity: Gravity.top,duration: 3);
                          return;
                        }
                        int code = await controller.createOrder();

                        if(code==200){
                          showSuccessModal(context);
                        }else{
                          edgeAlert(context,title: "Oops!",description: "Server error, creating orders!",backgroundColor: AppColor.orange,
                              icon: Icons.check_circle_outline_outlined, gravity: Gravity.top,duration: 3);
                        }
                      },
                      child: const Text("Send Order"),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: controller.getIsLoading(),
                child: const Center(
                  child: CircularProgressIndicator(backgroundColor: AppColor.primary),
                )
              )
            ],
          ),
        )
      ),
    );
  }
}

showSuccessModal(BuildContext context){
  return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      isScrollControlled: true,
      isDismissible: false,
      context: context,
      builder: (context) {
        return GetBuilder<CheckoutController>(
          builder:(controller)=> Container(
            height: Helper.getScreenHeight(context) * 0.9,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.clear),
                    ),
                  ],
                ),
                Image.asset(Helper.getAssetName("vector4.png", "virtual",),),
                const SizedBox(height: 20),
                const Text(
                  "Thank You!",
                  style: TextStyle(
                    color: AppColor.primary,
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 10),
                Text("for your order",
                  style: Helper.getTheme(context)
                      .headline4!.copyWith(color: AppColor.primary),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                      "Your order is now being processed. We will let you know once the order is picked from the outlet. Check the status of your order"),
                ),
                const SizedBox(height: 60),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 20),
                //   child: SizedBox(
                //     height: 50,
                //     width: double.infinity,
                //     child: ElevatedButton(
                //       onPressed: () {},
                //       child: Text("Track My Order"),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextButton(
                    onPressed: () {
                      controller.total = 0;
                      controller.setCartCount(0);

                      Get.off(()=>const Home());
                    },
                    child: const Text(
                      "Back To Home",
                      style: TextStyle(
                        color: AppColor.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      });
}

// TextButton(
//   onPressed: () {
//     showModalBottomSheet(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         isScrollControlled: true,
//         isDismissible: false,
//         context: context,
//         builder: (context) {
//           return Container(
//             height: Helper.getScreenHeight(context) * 0.7,
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment:
//                       MainAxisAlignment.end,
//                   children: [
//                     IconButton(
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                       icon: Icon(
//                         Icons.clear,
//                       ),
//                     )
//                   ],
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 20.0),
//                   child: Row(
//                     children: [
//                       Text(
//                         "Add Credit/Debit Card",
//                         style: Helper.getTheme(context)
//                             .headline3,
//                       )
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 20.0),
//                   child: Divider(
//                     color: AppColor.placeholder
//                         .withOpacity(0.5),
//                     thickness: 1.5,
//                     height: 40,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 20.0),
//                   child: CustomTextInput(
//                       hintText: "card Number"),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 20.0),
//                   child: Row(
//                     mainAxisAlignment:
//                         MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text("Expiry"),
//                       SizedBox(
//                         height: 50,
//                         width: 100,
//                         child: CustomTextInput(
//                           hintText: "MM",
//                           padding: const EdgeInsets.only(
//                               left: 35),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 50,
//                         width: 100,
//                         child: CustomTextInput(
//                           hintText: "YY",
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 20.0),
//                   child: CustomTextInput(
//                       hintText: "Security Code"),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 20.0),
//                   child: CustomTextInput(
//                       hintText: "First Name"),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 20.0),
//                   child: CustomTextInput(
//                       hintText: "Last Name"),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 20.0),
//                   child: Row(
//                     mainAxisAlignment:
//                         MainAxisAlignment.spaceBetween,
//                     children: [
//                       SizedBox(
//                         width: Helper.getScreenWidth(
//                                 context) *
//                             0.4,
//                         child: Text(
//                             "You can remove this card at anytime"),
//                       ),
//                       Switch(
//                         value: false,
//                         onChanged: (_) {},
//                         thumbColor:
//                             MaterialStateProperty.all(
//                           AppColor.secondary,
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 20.0),
//                   child: SizedBox(
//                     height: 50,
//                     child: ElevatedButton(
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                         },
//                         child: Row(
//                           mainAxisAlignment:
//                               MainAxisAlignment.center,
//                           children: [
//                             Icon(
//                               Icons.add,
//                             ),
//                             SizedBox(width: 40),
//                             Text("Add Card"),
//                             SizedBox(width: 40),
//                           ],
//                         )),
//                   ),
//                 )
//               ],
//             ),
//           );
//         });
//   },
//   child: Row(
//     children: [
//       Icon(Icons.add),
//       Text(
//         "Add Card",
//         style: TextStyle(
//           fontWeight: FontWeight.bold,
//         ),
//       )
//     ],
//   ),
// ),
