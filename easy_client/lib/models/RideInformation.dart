class RideInformation{
  final int id;
  final int distance;
  final int time;
  final int price;
  final int discountPrice;
  final int discountPercentage;

  RideInformation(this.id,this.distance,this.time,this.price,this.discountPercentage,this.discountPrice);

  RideInformation.fromJson(Map<String,dynamic> json):
      id=json['id'],
      distance=json['distance'],
      time=json['time'],
      price=json['price'],
      discountPercentage=json['discountPercentage'],
      discountPrice=json['discountPrice'];

  static RideInformation dummyRideInfo(){
    return RideInformation(1, 20, 45, 4000, 20, 3000);
  }
}