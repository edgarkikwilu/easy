import 'package:easy_client/models/Address.dart';
import 'package:easy_client/models/Cart.dart';

class Order{
  final int id;
  final Address address;
  final int payment;
  final String status;
  final int total;
  final DateTime createdAt;
  final List<Cart> items;

  Order(this.id,this.address,this.status,this.payment,this.total,this.createdAt,this.items);

  // 0: pending 1:processed 2: on delivery 3: delivered 4: cancelled
  Order.fromJson(Map<String,dynamic> json):
    id=json['id'],
    address=Address.fromJson(json['address']),
    status=Order.getStatus(json['status']),
    payment=json['payment'],
    total=json['total'],
    createdAt=DateTime.parse(json['created_at']),
    items=List.from(json['items'].map((e)=>Cart.fromJson(e)));

  static getStatus(int status){
    String stat = "Pending";

    switch(status){
      case 0:
        stat = "Pending";
        break;
      case 1:
        stat = "Processed";
        break;
      case 2:
        stat = "On Delivery";
        break;
      case 3:
        stat = "Delivered";
        break;
      case 4:
        stat = "Cancelled";
        break;
      default:
        stat = "Pending";
        break;
    }

    return stat;

  }

}