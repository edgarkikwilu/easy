import 'package:easy_client/models/Product.dart';

class Cart{
  final int id;
  final Product product;
  final int quantity;
  final int total;

  Cart(this.id,this.product,this.quantity,this.total);

  Cart.fromJson(Map<String,dynamic> json):
    id=json['id'],
    product=Product.fromJson(json['product']),
    quantity=json['quantity'],
    total=json['total'];
}