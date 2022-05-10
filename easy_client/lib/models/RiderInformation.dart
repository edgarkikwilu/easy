class RiderInformation{
  final int id;
  final String name;
  final String avatar;
  final String car;
  final int rating;
  final int completedTrips;

  RiderInformation(this.id,this.name,this.avatar,this.car,this.rating,this.completedTrips);

  RiderInformation.fromJson(Map<String,dynamic> json):
      id=json['id'],
      name=json['name'],
      avatar=json['avatar'],
      car=json['price'],
      completedTrips=json['completedTrips'],
      rating=json['rating'];

  static RiderInformation dummyRiderInfo(){
    return RiderInformation(1, "Edgar Kikwilu",
        "https://gravatar.com/avatar/5ebdfff3afb1607f45cd55c7733ea0ec?s=400&d=robohash&r=x",
        "Golf Gti", 4, 231);
  }
}