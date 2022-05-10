class Address{
  final int? id;
  final String? name;
  final String? lat;
  final String? lng;
  final int? isFavorite;

  Address(this.id,this.name,this.lat,this.lng,this.isFavorite);

  Address.fromJson(Map<String,dynamic> json):
      id=json['id'],
      name=json['name'],
      lat=json['lat'],
      lng=json['lng'],
      isFavorite=json['is_favorite'];
}