import 'package:easy_client/Helper/CustomTheme.dart';
import 'package:easy_client/Helper/colors.dart';
import 'package:easy_client/Helper/helper.dart';
import 'package:easy_client/cart/CartList.dart';
import 'package:easy_client/controllers/CheckoutController.dart';
import 'package:easy_client/controllers/HomeController.dart';
import 'package:easy_client/home_tab/product.dart';
import 'package:easy_client/models/Product.dart';
import 'package:easy_client/reusable/DessertCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsScreen extends StatelessWidget {
  static const routeName = '/dessertScreen';

  const ProductsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      id: 'products-screen',
      builder:(controller)=> Scaffold(
        body: FutureBuilder<List<Product>>(
            future: controller.fetchVendorProducts(),
            builder: (context,snapShot){
              if(snapShot.hasError){
                print(snapShot.stackTrace);
                return const Center(
                    heightFactor: 30,
                    child: Text("Error loading product categories")
                );
              }
              if(snapShot.connectionState == ConnectionState.done && snapShot.hasData && snapShot.data!.isNotEmpty){
                return SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Icon(
                                  Icons.arrow_back_ios_rounded,
                                  color: AppColor.primary,
                                ),
                              ),
                              // const SizedBox(width: 5),
                              Row(
                                children: [
                                  Text(
                                    "Products",
                                    style: Helper.getTheme(context).headline5,
                                  ),
                                ],
                              ),
                              GetBuilder<CheckoutController>(
                                id: 'products-cart',
                                builder:(_checkoutController)=> GestureDetector(
                                  onTap: (){
                                    Get.to(()=>const CartList());
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Stack(
                                      children: [
                                        Image.asset(Helper.getAssetName("cart.png", "images"),width: 32,),
                                        Positioned(
                                          right: 0,
                                          top: 0,
                                          child: CircleAvatar(
                                            radius: 8,
                                            backgroundColor: CustomColors.primary,
                                            child: Text("${_checkoutController.getCartCount()}",style: Theme.of(context).textTheme.caption?.apply(color: Colors.white)),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextFormField(
                              controller: controller.searchController,
                              onChanged: (value){
                                controller.searchProducts(value);
                              },
                              decoration: InputDecoration(
                                  hintText: "Search Food",
                                  fillColor: CustomColors.gray,
                                  filled: true,
                                  prefixIcon: const Icon(Icons.search),
                                  contentPadding: const EdgeInsets.only(left: 40),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide.none
                                  )
                              )
                          ),
                        ),
                        const SizedBox(height: 15),
                        GetBuilder<HomeController>(
                          id: 'products-list-section',
                          builder:(controller)=>ListView.builder(
                              itemCount: controller.getProducts().length,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context,index){
                                var product = controller.getProducts().elementAt(index);
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 220,
                                  margin: const EdgeInsets.only(bottom: 20),
                                  child: GestureDetector(
                                    onTap: (){
                                      controller.selectedProduct = product;
                                      Get.to(()=> ProductPage());
                                    },
                                    child: DessertCard(
                                      image: product.images[0],
                                      name: product.name,
                                      shop: product.name,
                                      rating: "3",
                                    ),
                                  ),
                                );
                              }
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
              if(snapShot.connectionState == ConnectionState.done && snapShot.hasData && snapShot.data!.isEmpty){
                return const Center(
                  heightFactor: 30,
                  child: Text("Empty results"),
                );
              }
              return const Center(
                heightFactor: 10,
                child: CircularProgressIndicator(color: AppColor.orange),
              );
            }
        )
      ),
    );
  }
}
