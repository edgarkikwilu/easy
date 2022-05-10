import 'package:easy_client/Helper/CustomTheme.dart';
import 'package:easy_client/Helper/helper.dart';
import 'package:easy_client/cart/CartList.dart';
import 'package:easy_client/controllers/CheckoutController.dart';
import 'package:easy_client/controllers/HomeController.dart';
import 'package:easy_client/home_tab/products.dart';
import 'package:easy_client/models/Vendor.dart';
import 'package:easy_client/reusable/RestaurantCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorScreen extends StatelessWidget {
  static const routeName = '/dessertScreen';

  const VendorScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      id: 'vendors-screen',
      builder:(controller)=> Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text("Restaurants", style: Theme.of(context).textTheme.headline5),
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          centerTitle: true,
          actions: [
            GetBuilder<CheckoutController>(
              id: 'vendors-cart',
              builder:(_checkoutController)=> GestureDetector(
                onTap: (){
                  Get.to(()=>const CartList());
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
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
          body: FutureBuilder<List<Vendor>>(
            future: controller.fetchVendors("food"),
            builder:(context, snapShot){
              if(snapShot.connectionState==ConnectionState.done && snapShot.hasError){
                return Center(
                  child: Text("Error fetching vendors",style: Theme.of(context).textTheme.subtitle2),
                );
              }
              if(snapShot.hasData){
                return SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: "Search restaurant",
                                fillColor: CustomColors.white,
                                filled: true,
                                prefixIcon: const Icon(Icons.search),
                                contentPadding: const EdgeInsets.only(left: 40),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none
                                )
                            ),
                            onChanged: (value){
                              controller.searchVendors(value);
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 150,
                          color: CustomColors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: ListView.builder(
                              itemCount: controller.getBanners().length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context,index){
                                var item = controller.getBanners().elementAt(index);
                                return Container(
                                  width: MediaQuery.of(context).size.width-150,
                                  height: 100,
                                  margin: const  EdgeInsets.only(right: 8,left: 8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      Helper.getAssetName(item, "images"),
                                      width: MediaQuery.of(context).size.width-50,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                );
                              }
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 130,
                          child: ListView.builder(
                              itemCount: controller.getStories().length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context,index){
                                var story = controller.getStories().elementAt(index);
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundColor: CustomColors.white,
                                    backgroundImage: AssetImage(
                                      Helper.getAssetName(story, "images"),
                                    ),
                                  ),
                                );
                              }
                          ),
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Text("Restaurants",style: Theme.of(context).textTheme.headline6!.copyWith(color: CustomColors.dark)),
                        ),
                        const SizedBox(height: 12),
                        GetBuilder<HomeController>(
                          id: 'vendors-list-section',
                          builder:(controller)=> GridView.builder(
                              itemCount: controller.getVendors().length,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 4.0,
                                  mainAxisSpacing: 12
                              ),
                              itemBuilder: (context,index){
                                var vendor = controller.getVendors().elementAt(index);
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 300,
                                  margin: const EdgeInsets.symmetric(horizontal: 5),
                                  child: GestureDetector(
                                      onTap: (){
                                        Get.to(()=>const ProductsScreen());
                                      },
                                      child: RestaurantCard(
                                          image: Image.network(
                                            vendor.image,
                                            fit: BoxFit.cover,
                                          ),
                                          name: vendor.name,
                                          rating: vendor.rating
                                      )
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
              return Center(
                child: CircularProgressIndicator(backgroundColor: CustomColors.primary),
              );
            },
          )
      ),
    );
  }
}