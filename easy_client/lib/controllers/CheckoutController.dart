import 'dart:convert';

import 'package:easy_client/Helper/helper.dart';
import 'package:easy_client/models/Address.dart';
import 'package:easy_client/models/Cart.dart';
import 'package:easy_client/models/Order.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:get/get.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:http/http.dart' as http;

class CheckoutController extends GetxController{
  int quantity = 0;
  int total = 0;
  int _cartCount = 0;
  String _paymentMethod = "cash";
  late Address selectedAddress;
  late Address tempAddress;

  Address nullAddress = Address(1, "", '', '', 1);

  List<Cart> carts = [];
  List<Address> addresses = [];

  bool _isLoading = false;
  bool _isClearingCart = false;

  bool getIsLoading() => _isLoading;
  bool getIsClearingCart() => _isClearingCart;
  int getCartCount() => _cartCount;
  String getPaymentMethod() => _paymentMethod;

  setIsLoading(bool isLoading){
    _isLoading = isLoading;
    update(['individual']);
  }

  setIsClearingCart(bool isClearingCart){
    _isClearingCart = isClearingCart;
    update(['cart-screen']);
  }

  setCartCount(int count){
    _cartCount = count;
    update(['cart-icon']);
  }

  setPaymentMethod(String paymentMethod){
    _paymentMethod = paymentMethod;
    update(['checkout-screen']);
  }

  setSelectedAddress(Address address){
    selectedAddress = address;
    update(['checkout-screen','delivery_address_selector']);
  }

  updateQuantity(String step,int price){
    if(step=='dec' && quantity == 0) return;
    else {
      step=='inc'?quantity++:quantity--;
      total = price * quantity;
      print(quantity);
      update(['individual']);
    }
  }

  Future<int> clearCart()async{
    await Future.delayed(const Duration(seconds: 2),(){});
    setCartCount(0);
    total = 0;
    carts.clear();
    return 200;
  }

  Future<int> searchNewAddress(BuildContext context) async{
    const kGoogleApiKey = "AIzaSyCSi12poFvXyne9daqQNYlt04iZyx5jomM";

    var p = await PlacesAutocomplete.show(
        context: context,
        apiKey: kGoogleApiKey,
        mode: Mode.overlay, // Mode.fullscreen
        language: "en",
        offset: 0,
        radius: 1000000,
        types: [],
        strictbounds: false,
        onError: (error){
          print("search error");
          print(error.errorMessage);
          return;
        },
        components: []);

    final places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
    PlacesDetailsResponse placesDetailsResponse = await places.getDetailsByPlaceId(p!.placeId!);
    if(placesDetailsResponse.isOkay){
      print(placesDetailsResponse.result.geometry!.location.lat);
      Address address = Address(p.distanceMeters, p.description,
          "${placesDetailsResponse.result.geometry!.location.lat}",
          "${placesDetailsResponse.result.geometry!.location.lng}", 0);
      // addresses.add(address);
      tempAddress = address;

      return 0;
    }
    return 1;
  }

  Future<int> addAddress(Address address) async{
    setIsLoading(true);
    update(['save-address-dialog']);

    var response = await http.post(Helper.parseUrl("customer/add/address"),
        headers: Helper.getHeaders(),
        body: jsonEncode(<String,dynamic>{
          "name":address.name,
          "latitude":address.lat,
          "longitude":address.lng,
          "isFavorite":false
        })
    );

    setIsLoading(false);

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      selectedAddress = Address.fromJson(data['address']);
      update(['address-screen','save-address-dialog']);
    }else{
      print(response.statusCode);
      print(response.body);
    }

    return response.statusCode;
  }

  Future<int> addToCart(int productId) async{
    setIsLoading(true);
    if(quantity == 0 && total == 0){
      return 402;
    }
    var response = await http.post(Helper.parseUrl("customer/add/cart"),
        headers: Helper.getHeaders(),
        body: jsonEncode(<String,int>{
          "product_id":productId,
          "quantity":quantity,
          "total":total
        })
    );

    if(response.statusCode == 200){
      setCartCount(getCartCount()+1);
      update(['cart-icon','products-cart','vendors-cart']);
    }

    setIsLoading(false);

    print(response.statusCode);
    print(response.body);

    return response.statusCode;
  }

  Future<List<Cart>> loadCart() async{
    setIsLoading(true);

    var response = await http.get(
        Helper.parseUrl("customer/cart"),
        headers: Helper.getHeaders()
    );
    carts.clear();

    setIsLoading(false);

    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      List.from(data['cart'].map((e)=>carts.add(Cart.fromJson(e))));
      total = 0;
      carts.forEach((cart) { total +=cart.total; });
    }

    print(response.statusCode);
    print(response.body);

    return carts;
  }

  Future<int> updateCart(String step,Cart cart) async{
    setIsLoading(true);
    // update(['checkout-screen']);
    int total = cart.total;
    int quantity = cart.quantity;

    if(step == 'inc'){
      quantity += 1;
      total += cart.product.price;
    }else if(step == 'dec'){
      if(quantity == 0){
        return 0;
      }
      quantity -= 1;
      total -= cart.product.price;
    }

    var response = await http.post(Helper.parseUrl("customer/update/cart"),
        headers: Helper.getHeaders(),
        body: jsonEncode(<String,dynamic>{
          "id":cart.id,
          "quantity":quantity,
          "total":total
        })
    );

    setIsLoading(false);

    if(response.statusCode != 200){
      print(response.statusCode);
      print(response.body);
    }else{
      update(['cart-screen']);
    }

    return response.statusCode;
  }

  Future<List<Address>> loadAddresses() async{
    setIsLoading(true);

    var response = await http.get(
        Helper.parseUrl("customer/addresses"),
        headers: Helper.getHeaders()
    );
    addresses.clear();

    setIsLoading(false);

    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      List.from(data['addresses'].map((e)=>addresses.add(Address.fromJson(e))));

    }

    print(response.statusCode);
    print(response.body);

    return addresses;
  }

  Future<int> createOrder() async{
    setIsLoading(true);
    update(['checkout-screen']);

    var response = await http.post(Helper.parseUrl("customer/checkout"),
        headers: Helper.getHeaders(),
        body: jsonEncode(<String,dynamic>{
          "delivery_address":selectedAddress.id,
          "delivery_date":DateTime.now().toIso8601String(),
          "total":total
        })
    );

    setIsLoading(false);
    update(['checkout-screen']);

    if(response.statusCode != 200){
      print(response.statusCode);
      print(response.body);
    }

    return response.statusCode;
  }

  Future<Order> getOrder() async{
    var response = await http.get(Helper.parseUrl("customer/order"),
        headers: Helper.getHeaders()
    );

    if(response.statusCode != 200){
      print(response.statusCode);
      print(response.body);
      // return null;
    }
    print(response.body);
    final data = jsonDecode(response.body);
    Order order = Order.fromJson(data['order']);
    return order;
  }
}