import 'dart:convert';

import 'package:easy_client/Helper/helper.dart';
import 'package:easy_client/models/Category.dart';
import 'package:easy_client/models/Product.dart';
import 'package:easy_client/models/Vendor.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController{

  TextEditingController searchController = TextEditingController();

  int _selectedIndex = 0;
  final bool _isLoading = false;
  final List<Category> _categories = [];
  List<Product> _products = [];
  List<Vendor> _vendors = [];
  List<Product> _recommendedProducts = [];
  final List<String> _banners = [];
  final List<String> _stories = [];
  late Category selectedCategory;
  late Product selectedProduct;

  int getSelectedIndex() => _selectedIndex;
  List<Product> getProducts() => _products;
  List<Vendor> getVendors() => _vendors;
  List<Product> getRecommendedProducts() => _recommendedProducts;
  List<Category> getCategories() => _categories;
  List<String> getBanners() => _banners;
  List<String> getStories() => _stories;
  bool getIsLoading() => _isLoading;

  setSelectedIndex(int index){
    _selectedIndex = index;
    update(['home']);
  }

  Future<List<Category>> loadCategories() async{
    var response = await http.get(Helper.parseUrl("customer/categories"),headers: Helper.getHeaders());
    _categories.clear();
    print(response.statusCode);
    print(response.body);

    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      List<Category>.from(data['categories'].map((e) => _categories.add(Category.fromJson(e))));
    }
    return _categories;
  }

  Future<List<Product>> fetchRecommendedProducts() async{
    //${selectedCategory.id}
    // return await Product.getDummyProducts();
    var response = await http.get(Helper.parseUrl("products"),headers: Helper.getHeaders());
    _recommendedProducts.clear();
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      _recommendedProducts = List.from(data['data'].map((product)=>Product.fromJson(product)));
    }else{
      print(response.request!.url);
      print(response.statusCode);
      print(response.body);
    }

    return _recommendedProducts;
  }

  Future<List<Product>> fetchVendorProducts() async{
    //${selectedCategory.id}
    var response = await http.get(Helper.parseUrl("products"),headers: Helper.getHeaders());
    _products.clear();
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      _products = List.from(data['data'].map((product)=>Product.fromJson(product)));
    }else{
      print(response.request!.url);
      print(response.statusCode);
      print(response.body);
    }
    return _products;
  }

  searchProducts(String search) async{
    print("searching.... $search");
    List<Product> result = [];

    if(search.isEmpty){
      await fetchVendorProducts();
      update(['products-list-section']);
      return;
    }
    // _products.clear();

    for (var product in _products) {
      if(product.name.toLowerCase().contains(search.toLowerCase())) {
        result.add(product);
      } else if(product.description.toLowerCase().contains(search.toLowerCase())) {
        result.add(product);
      }
      // else if(product.category.name.toLowerCase().contains(search.toLowerCase())) {
      //   result.add(product);
      // }
    }

    _products = result;
    update(['products-list-section']);
    return;
    if(search.isEmpty){
      await fetchRecommendedProducts();
      update(['products-screen']);
      return _products;
    }
    var response = await http.get(Helper.parseUrl("customer/search/$search"),headers: Helper.getHeaders());
    _products.clear();
    print(response.statusCode);
    print(response.body);

    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      List<Category>.from(data['products'].map((e) => _products.add(Product.fromJson(e))));
      update(['products-screen']);
    }
    return _products;
  }

  Future<List<Vendor>> fetchVendors(String type) async{
    _banners.clear();
    _stories.clear();

    _banners.add("burger.png");
    _banners.add("burger.png");
    _banners.add("burger.png");
    _stories.add("burger.png");
    _stories.add("burger.png");
    _stories.add("burger.png");

    _vendors = await Vendor.getDummyVendors();
    return _vendors;

    var response = await http.get(Helper.parseUrl("vendors/$type"),headers: Helper.getHeaders());
    _vendors.clear();
    print(response.statusCode);
    print(response.body);

    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      List<Vendor>.from(data['vendors'].map((e) => _vendors.add(Vendor.fromJson(e))));
      update(['vendors-screen']);
    }
    return _vendors;
  }

  searchVendors(String search) async{
    print("searching.... $search");
    List<Vendor> result = [];

    if(search.isEmpty){
      await fetchVendors("food");
      update(['vendors-list-section']);
      return;
    }
    // _vendors.clear();

    for (var vendor in _vendors) {
      if(vendor.name.toLowerCase().contains(search.toLowerCase())) result.add(vendor);
    }

    _vendors = result;
    update(['vendors-list-section']);
    return;

    var response = await http.get(Helper.parseUrl("search/$search"),headers: Helper.getHeaders());
    _vendors.clear();
    print(response.statusCode);
    print(response.body);

    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      List<Vendor>.from(data['vendors'].map((e) => _vendors.add(Vendor.fromJson(e))));
      update(['vendors-screen']);
    }
  }
}