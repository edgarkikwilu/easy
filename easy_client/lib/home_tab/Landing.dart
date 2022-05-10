import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_client/Helper/CustomTheme.dart';
import 'package:easy_client/Helper/colors.dart';
import 'package:easy_client/Helper/helper.dart';
import 'package:easy_client/cart/CartList.dart';
import 'package:easy_client/controllers/CheckoutController.dart';
import 'package:easy_client/controllers/HomeController.dart';
import 'package:easy_client/controllers/MapController.dart';
import 'package:easy_client/home_tab/Item.dart';
import 'package:easy_client/home_tab/Map.dart';
import 'package:easy_client/home_tab/product.dart';
import 'package:easy_client/home_tab/Vendors.dart';
import 'package:easy_client/models/Product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LandingPage extends StatelessWidget{
  LandingPage({Key? key}) : super(key: key);

  final CheckoutController _checkoutController = Get.put(CheckoutController());
  final MapController _mapController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      id: 'landing',
      builder: (controller)=>Scaffold(
        backgroundColor: CustomColors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset("assets/brand/logo_transparent.jpg", width: 100, fit: BoxFit.contain),
                        GetBuilder<CheckoutController>(
                          id: 'landing-cart',
                          builder:(_checkoutController)=> GestureDetector(
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
                                    child: Text("${_checkoutController.getCartCount()}",style: Theme.of(context).textTheme.caption?.apply(color: Colors.white)),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: (){
                            Get.to(()=>MapPage());
                          },
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: CustomColors.gray,
                                radius: 35,
                                child: Image.asset(Helper.getAssetName("car.png", "images"),height: 40,fit: BoxFit.contain)
                              ),
                              const SizedBox(height: 10),
                              Text("Car",style: Theme.of(context).textTheme.caption)
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: (){
                            Get.to(()=>const VendorScreen());
                          },
                          child: Column(
                            children: [
                              CircleAvatar(
                                  backgroundColor: CustomColors.gray,
                                  radius: 35,
                                  child: Image.asset(Helper.getAssetName("food.png", "images"),height: 40,fit: BoxFit.contain)
                              ),
                              const SizedBox(height: 10),
                              Text("Food",style: Theme.of(context).textTheme.caption)
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: (){
                            Get.to(()=>const VendorScreen());
                          },
                          child: Column(
                            children: [
                              CircleAvatar(
                                  backgroundColor: CustomColors.gray,
                                  radius: 35,
                                  child: Image.asset(Helper.getAssetName("groceries.png", "images"),height: 40,fit: BoxFit.contain)
                              ),
                              const SizedBox(height: 10),
                              Text("Groceries",style: Theme.of(context).textTheme.caption)
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: (){
                            Get.to(()=>MapPage());
                          },
                          child: Column(
                            children: [
                              CircleAvatar(
                                  backgroundColor: CustomColors.gray,
                                  radius: 35,
                                  child: Image.asset(Helper.getAssetName("bicycle.png", "images"),height: 40,fit: BoxFit.contain)
                              ),
                              const SizedBox(height: 10),
                              Text("Bike",style: Theme.of(context).textTheme.caption)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: (){
                            // Get.to(()=>MapPage());
                          },
                          child: Column(
                            children: [
                              CircleAvatar(
                                  backgroundColor: CustomColors.gray,
                                  radius: 35,
                                  child: Image.asset(Helper.getAssetName("delivery.png", "images"),height: 40,fit: BoxFit.contain)
                              ),
                              const SizedBox(height: 10),
                              Text("Delivery",style: Theme.of(context).textTheme.caption)
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: (){
                            // Get.to(()=>const VendorScreen());
                          },
                          child: Column(
                            children: [
                              CircleAvatar(
                                  backgroundColor: CustomColors.gray,
                                  radius: 35,
                                  child: Image.asset(Helper.getAssetName("send_credit.png", "images"),height: 40,fit: BoxFit.contain)
                              ),
                              const SizedBox(height: 10),
                              Text("Send Credit",style: Theme.of(context).textTheme.caption)
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: (){
                            // Get.to(()=>const VendorScreen());
                          },
                          child: Column(
                            children: [
                              CircleAvatar(
                                  backgroundColor: CustomColors.gray,
                                  radius: 35,
                                  child: Image.asset(Helper.getAssetName("pcr.png", "images"),height: 40,fit: BoxFit.contain)
                              ),
                              const SizedBox(height: 10),
                              Text("PCR Test",style: Theme.of(context).textTheme.caption)
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: (){
                            Get.to(()=>MapPage());
                          },
                          child: Column(
                            children: [
                              CircleAvatar(
                                  backgroundColor: CustomColors.gray,
                                  radius: 35,
                                  child: Image.asset(Helper.getAssetName("taxi.png", "images"),height: 40,fit: BoxFit.contain)
                              ),
                              const SizedBox(height: 10),
                              Text("Hala Tax",style: Theme.of(context).textTheme.caption)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 48),
                  Card(
                    elevation: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Container(
                          height: 330,
                          padding: const EdgeInsets.only(bottom: 10,top: 20,left: 20),
                          color: CustomColors.gray,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Recommended for you".toUpperCase(), style: Theme.of(context).textTheme.subtitle2),
                              const SizedBox(height: 20),
                              FutureBuilder<List<Product>>(
                                  future: controller.fetchRecommendedProducts(),
                                  builder: (context,snapShot){
                                    if(snapShot.hasError){
                                      print(snapShot.stackTrace);
                                      return const Center(child: Text("Error fetching data"));
                                    }
                                    if(snapShot.hasData && snapShot.data!.isEmpty){
                                      return const Center(child: Text("No data"));
                                    }
                                    if(snapShot.hasData && snapShot.data!.isNotEmpty){
                                      return SizedBox(
                                        height: 250,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: 3,
                                            itemBuilder: (context,index){
                                              var product = snapShot.data!.elementAt(index);
                                              return GestureDetector(
                                                onTap: (){
                                                  controller.selectedProduct = product;
                                                  Get.to(()=>ProductPage());
                                                },
                                                child: Card(
                                                  margin: const EdgeInsets.only(right: 16),
                                                  elevation: 10,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      CachedNetworkImage(
                                                        height: 180,fit: BoxFit.fitWidth,
                                                        imageUrl: product.images[0],
                                                        placeholder: (context, url) => Image.asset(Helper.getAssetName("burger.png", "images")),
                                                        errorWidget: (context, url, error) => Image.asset(Helper.getAssetName("burger.png", "images")),
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left:8.0),
                                                        child: Text(product.name, style: Theme.of(context).textTheme.subtitle2),
                                                      ),
                                                      const SizedBox(height: 4),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left:8.0),
                                                        child: Text(product.vendorName,
                                                            style: Theme.of(context).textTheme.caption!.copyWith(color: CustomColors.primary)),
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                              );
                                            }
                                        ),
                                      );
                                    }
                                    return const Center(child: CircularProgressIndicator(backgroundColor: AppColor.orange));
                                  }
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 48),
                  GetBuilder<MapController>(
                    id: 'home-book-ride-card',
                    builder:(mapController)=> Card(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 13),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Text("Book a ride".toUpperCase(),style: Theme.of(context).textTheme.caption),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 40,
                              child: TextFormField(
                                controller: mapController.pickupLocationController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.radio_button_unchecked,color: CustomColors.primary,size: 12),
                                  hintText: "Enter your pickup location...",
                                  fillColor: CustomColors.gray.withOpacity(0.5),
                                  filled: true,
                                  border: const OutlineInputBorder(borderSide: BorderSide.none)
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: (){},
                              child: Container(
                                height: 40,
                                width: MediaQuery.of(context).size.width-40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: CustomColors.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(30)
                                ),
                                child: Text("Select Pickup", style: Theme.of(context).textTheme.button!
                                    .copyWith(color: CustomColors.primary,fontWeight: FontWeight.w900)),
                              )
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        )
      )
    );
  }
}