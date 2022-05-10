class Delivery{
  final int? id;
  final String? userName;
  final String? phoneNumber;
  final String? deliveryAddress;
  final double? pickupLat;
  final double? pickupLng;
  final double? destinationLat;
  final double? destinationLng;
  final int? amount;

  Delivery(this.id,this.userName,this.phoneNumber,this.deliveryAddress,this.pickupLat,this.pickupLng,
      this.destinationLat,this.destinationLng,this.amount);

  Delivery.fromJson(Map<String,dynamic> json):
      id=json['id'],
      userName=json['user_name'],
      phoneNumber=json['phone_number'],
      deliveryAddress=json['delivery_address'],
      pickupLat=double.parse(json['pickup_lat']),
      pickupLng=double.parse(json['pickup_lng']),
      destinationLat=double.parse(json['destination_lat']),
      destinationLng=double.parse(json['destination_lng']),
      amount=json['amount'];
}