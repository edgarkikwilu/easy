class Vendor{
  final int id;
  final String name;
  final String image;
  final int rating;

  Vendor(this.id,this.name,this.image,this.rating);

  Vendor.fromJson(Map<String,dynamic> json):
        id=json['id'],
        name=json['name'],
        image=json['image'],
        rating=json['rating'];

  static Future<List<Vendor>> getDummyVendors() async{
    Vendor vendor = Vendor(1, "King of meat", 'https://i.picsum.photos/id/488/1772/1181.jpg?hmac=psl3qLyDefO6AYqU4TJQ8PNCjS8RdPiP_vRLB8WPVjY', 2);
    Vendor vendor1 = Vendor(2, "Spirit", 'https://i.picsum.photos/id/488/1772/1181.jpg?hmac=psl3qLyDefO6AYqU4TJQ8PNCjS8RdPiP_vRLB8WPVjY', 5);
    Vendor vendor3 = Vendor(3, "Capetown Fish Market", 'https://i.picsum.photos/id/488/1772/1181.jpg?hmac=psl3qLyDefO6AYqU4TJQ8PNCjS8RdPiP_vRLB8WPVjY', 3);

    await Future.delayed(const Duration(seconds: 2),(){});

    return List.of([vendor,vendor1,vendor3]);
  }
}