import 'package:easy_client/Helper/CustomTheme.dart';
import 'package:easy_client/Helper/colors.dart';
import 'package:easy_client/Helper/helper.dart';
import 'package:easy_client/cart/CartList.dart';
import 'package:easy_client/controllers/CheckoutController.dart';
import 'package:easy_client/controllers/HomeController.dart';
import 'package:edge_alerts/edge_alerts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductPage extends StatelessWidget {
  static const routeName = "/individualScreen";
  final HomeController _homeController = Get.find();

  ProductPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckoutController>(
      id: 'individual',
      builder:(controller)=> Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            height: Helper.getScreenHeight(context) * 0.5,
                            width: Helper.getScreenWidth(context),
                            child: Image.asset(
                              Helper.getAssetName("burger.png", "images"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            height: Helper.getScreenHeight(context) * 0.5,
                            width: Helper.getScreenWidth(context),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: const [0.0, 0.4],
                                colors: [
                                  Colors.black.withOpacity(0.9),
                                  Colors.black.withOpacity(0.0),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SafeArea(
                        child: Column(
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.only(left: 20.0,right: 20,top: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Icon(
                                      Icons.arrow_back_ios_rounded,
                                      color: Colors.white,
                                    ),
                                  ),
                                  GetBuilder<CheckoutController>(
                                    id: 'cart-icon',
                                    builder:(checkoutController)=> GestureDetector(
                                      onTap: (){
                                        Get.to(()=>const CartList());
                                      },
                                      child: Stack(
                                        children: [
                                          Image.asset(Helper.getAssetName("cart.png", "images"),width: 32,),
                                          Positioned(
                                            right: 0,
                                            top: 0,
                                            child: CircleAvatar(
                                              radius: 8,
                                              backgroundColor: CustomColors.primary,
                                              child: Text("${checkoutController.getCartCount()}",style: Theme.of(context).textTheme.caption!.apply(color: Colors.white)),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: Helper.getScreenHeight(context) * 0.35,
                            ),
                            SizedBox(
                              height: 600,
                              width: double.infinity,
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 30.0),
                                    child: Container(
                                      height: 700,
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(vertical: 30),
                                      decoration: const ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(40),
                                            topRight: Radius.circular(40),
                                          ),
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20),
                                            child: Text(
                                              _homeController.selectedProduct.name,
                                              style: Helper.getTheme(context).headline5,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          height:24,
                                                          child: ListView.builder(
                                                              scrollDirection: Axis.horizontal,
                                                              itemCount: 4,
                                                              shrinkWrap: true,
                                                              itemBuilder: (context,index){
                                                                return Icon(Icons.star,color: CustomColors.primary,size: 16);
                                                              }
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:24,
                                                          child: ListView.builder(
                                                              scrollDirection: Axis.horizontal,
                                                              itemCount: 1,
                                                              shrinkWrap: true,
                                                              itemBuilder: (context,index){
                                                                return const Icon(Icons.star,color: AppColor.placeholder,size: 16);
                                                              }
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                      "4 Star Ratings",
                                                      style: TextStyle(color: CustomColors.someGray, fontSize: 12,),
                                                    )
                                                  ],
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                    children: [
                                                      const SizedBox(height: 20),
                                                      Text(
                                                        "Tsh. ${_homeController.selectedProduct.price}",
                                                        style: const TextStyle(
                                                          color: AppColor.primary,
                                                          fontSize: 30,
                                                          fontWeight:
                                                          FontWeight.w700,
                                                        ),
                                                      ),
                                                      Text("/ per Item",style: Theme.of(context).textTheme.caption)
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Text(
                                              "Description",
                                              style: Helper.getTheme(context).headline4!.copyWith(fontSize: 16),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Text(
                                                _homeController.selectedProduct.description),
                                          ),
                                          const SizedBox(height: 20),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 20),
                                            child: Divider(
                                              color: AppColor.placeholder,
                                              thickness: 1.5,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          // Padding(
                                          //   padding: const EdgeInsets.symmetric(
                                          //       horizontal: 20),
                                          //   child: Text(
                                          //     "Customize your Order",
                                          //     style: Helper.getTheme(context)
                                          //         .headline4
                                          //         .copyWith(
                                          //           fontSize: 16,
                                          //         ),
                                          //   ),
                                          // ),
                                          // SizedBox(
                                          //   height: 10,
                                          // ),
                                          // Padding(
                                          //   padding: const EdgeInsets.symmetric(
                                          //       horizontal: 20),
                                          //   child: Container(
                                          //     height: 50,
                                          //     width: double.infinity,
                                          //     padding: const EdgeInsets.only(
                                          //         left: 30, right: 10),
                                          //     decoration: ShapeDecoration(
                                          //       shape: RoundedRectangleBorder(
                                          //         borderRadius:
                                          //             BorderRadius.circular(5),
                                          //       ),
                                          //       color: AppColor.placeholderBg,
                                          //     ),
                                          //     child: DropdownButtonHideUnderline(
                                          //       child: DropdownButton(
                                          //         hint: Row(
                                          //           children: [
                                          //             Text("-Select the size of portion-"),
                                          //           ],
                                          //         ),
                                          //         value: "default",
                                          //         onChanged: (_) {},
                                          //         items: [
                                          //           DropdownMenuItem(
                                          //             child: Text("-Select the size of portion-"),
                                          //             value: "default",
                                          //           ),
                                          //         ],
                                          //         icon: Icon(Icons.keyboard_arrow_down_sharp,size: 32),
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                          // SizedBox(
                                          //   height: 5,
                                          // ),
                                          // Padding(
                                          //   padding: const EdgeInsets.symmetric(
                                          //       horizontal: 20),
                                          //   child: Container(
                                          //     height: 50,
                                          //     width: double.infinity,
                                          //     padding: const EdgeInsets.only(
                                          //         left: 30, right: 10),
                                          //     decoration: ShapeDecoration(
                                          //       shape: RoundedRectangleBorder(
                                          //         borderRadius:
                                          //             BorderRadius.circular(5),
                                          //       ),
                                          //       color: AppColor.placeholderBg,
                                          //     ),
                                          //     child: DropdownButtonHideUnderline(
                                          //       child: DropdownButton(
                                          //         hint: Row(
                                          //           children: [
                                          //             Text("-Select the ingredients-"),
                                          //           ],
                                          //         ),
                                          //         value: "default",
                                          //         onChanged: (_) {},
                                          //         items: [
                                          //           DropdownMenuItem(
                                          //             child: Text("-Select the ingredients-"),
                                          //             value: "default",
                                          //           ),
                                          //         ],
                                          //         icon: Icon(Icons.keyboard_arrow_down_sharp,size: 32),
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                          const SizedBox(height: 15),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Number of Items",
                                                  style: Helper.getTheme(context).caption!.copyWith(fontSize: 16),
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                    children: [
                                                      ElevatedButton(
                                                        style: ButtonStyle(elevation: MaterialStateProperty.all(5.0)),
                                                        onPressed: () {
                                                          controller.updateQuantity('dec', _homeController.selectedProduct.price);
                                                        },
                                                        child: const Text("-"),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      Container(
                                                        height: 35,
                                                        width: 55,
                                                        decoration:
                                                        ShapeDecoration(
                                                          shape: StadiumBorder(
                                                            side: BorderSide(color: CustomColors.white),
                                                          ),
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Text(
                                                              "${controller.quantity}",
                                                              style: const TextStyle(color: Colors.black, fontSize: 24),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      ElevatedButton(
                                                        style: ButtonStyle(elevation: MaterialStateProperty.all(5.0)),
                                                        onPressed: () {
                                                          controller.updateQuantity('inc', _homeController.selectedProduct.price);
                                                        },
                                                        child: const Text("+"),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 45),
                                          SizedBox(
                                            height: 200,
                                            width: double.infinity,
                                            child: Stack(
                                              children: [
                                                Container(
                                                  width: 120,
                                                  decoration: ShapeDecoration(
                                                    color: CustomColors.primary,
                                                    shape: const RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.only(
                                                        topRight: Radius.circular(40),
                                                        bottomRight: Radius.circular(40),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                  Alignment.centerRight,
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                                    child: Container(
                                                      height: 160,
                                                      width: double.infinity,
                                                      margin:
                                                      const EdgeInsets.only(left: 50, right: 40),
                                                      decoration: ShapeDecoration(
                                                        shape: const RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.only(
                                                            topLeft: Radius.circular(40),
                                                            bottomLeft: Radius.circular(40),
                                                            topRight: Radius.circular(10),
                                                            bottomRight: Radius.circular(10),
                                                          ),
                                                        ),
                                                        shadows: [
                                                          BoxShadow(
                                                            color: AppColor.placeholder.withOpacity(0.3),
                                                            offset: const Offset(0, 5),
                                                            blurRadius: 5,
                                                          ),
                                                        ],
                                                        color: Colors.white,
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          const Text("Total Price"),
                                                          const SizedBox(height: 10),
                                                          Text(
                                                            "Tsh ${controller.total}",
                                                            style: const TextStyle(
                                                              color: AppColor.primary,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 20,
                                                            ),
                                                          ),
                                                          const SizedBox(height: 10),
                                                          Visibility(
                                                              visible: controller.getIsLoading(),
                                                              child: const Center(child: CircularProgressIndicator())
                                                          ),
                                                          Visibility(
                                                            visible: !controller.getIsLoading(),
                                                            child: SizedBox(
                                                              width: 200,
                                                              child: ElevatedButton(
                                                                  onPressed: () async{
                                                                    var code = await controller.addToCart(_homeController.selectedProduct.id);
                                                                    controller.setIsLoading(false);
                                                                    if(code == 200){
                                                                      edgeAlert(context,title: "Success!",description: "Product added to cart",backgroundColor: AppColor.primary,
                                                                          icon: Icons.error_outline_outlined, gravity: Gravity.top,duration: 3);
                                                                      // Navigator.pop(context);
                                                                      controller.total = 0;
                                                                      controller.quantity = 0;
                                                                    }else if(code == 402){
                                                                      edgeAlert(context,title: "Oops!",description: "Please select product quantity",backgroundColor: AppColor.orange,
                                                                          icon: Icons.error_outline_outlined, gravity: Gravity.top,duration: 3);
                                                                      controller.total = 0;
                                                                      controller.quantity = 0;

                                                                    }else{
                                                                      edgeAlert(context,title: "Oops!",description: "Something went wrong",backgroundColor: AppColor.orange,
                                                                          icon: Icons.error_outline_outlined, gravity: Gravity.top,duration: 3);
                                                                    }
                                                                  },
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    mainAxisSize: MainAxisSize.min,
                                                                    children: [
                                                                      Image.asset(
                                                                        Helper.getAssetName(
                                                                            "add_to_cart.png",
                                                                            "images"),
                                                                      ),
                                                                      const Text("Add to Cart")
                                                                    ],
                                                                  )),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 20),
                                                  child: Align(
                                                    alignment:
                                                    Alignment.centerRight,
                                                    child: Container(
                                                      width: 60,
                                                      height: 60,
                                                      decoration: ShapeDecoration(
                                                        color: Colors.white,
                                                        shadows: [
                                                          BoxShadow(
                                                            color: AppColor.placeholder.withOpacity(0.3),
                                                            offset: const Offset(0, 5),
                                                            blurRadius: 5,
                                                          ),
                                                        ],
                                                        shape: const CircleBorder(),
                                                      ),
                                                      child: Icon(Icons.shopping_cart_sharp,color:CustomColors.primary),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(
                                  //     right: 20,
                                  //   ),
                                  //   child: Align(
                                  //     alignment: Alignment.topRight,
                                  //     child: ClipShadow(
                                  //       clipper: CustomTriangle(),
                                  //       boxShadow: [
                                  //         BoxShadow(
                                  //           color: AppColor.placeholder,
                                  //           offset: Offset(0, 5),
                                  //           blurRadius: 5,
                                  //         ),
                                  //       ],
                                  //       child: Container(
                                  //         width: 60,
                                  //         height: 60,
                                  //         color: Colors.white,
                                  //         child: Icon(Icons.favorite,color:AppColor.orange),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomTriangle extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Offset controlpoint = Offset(size.width * 0, size.height * 0.5);
    Offset endpoint = Offset(size.width * 0.2, size.height * 0.85);
    Offset controlpoint2 = Offset(size.width * 0.33, size.height);
    Offset endpoint2 = Offset(size.width * 0.6, size.height * 0.9);
    Offset controlpoint3 = Offset(size.width * 1.4, size.height * 0.5);
    Offset endpoint3 = Offset(size.width * 0.6, size.height * 0.1);
    Offset controlpoint4 = Offset(size.width * 0.33, size.height * 0);
    Offset endpoint4 = Offset(size.width * 0.2, size.height * 0.15);

    Path path = new Path()
      ..moveTo(size.width * 0.2, size.height * 0.15)
      ..quadraticBezierTo(
        controlpoint.dx,
        controlpoint.dy,
        endpoint.dx,
        endpoint.dy,
      )
      ..quadraticBezierTo(
        controlpoint2.dx,
        controlpoint2.dy,
        endpoint2.dx,
        endpoint2.dy,
      )
      ..quadraticBezierTo(
        controlpoint3.dx,
        controlpoint3.dy,
        endpoint3.dx,
        endpoint3.dy,
      )
      ..quadraticBezierTo(
        controlpoint4.dx,
        controlpoint4.dy,
        endpoint4.dx,
        endpoint4.dy,
      );

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
