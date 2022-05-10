import 'package:easy_client/models/Category.dart';

class Product{
  final int id;
  final String name;
  final String vendorName;
  final List<String> images;
  final int price;
  final int discountPrice;
  final int quantity;
  final String description;
  // final Category category;
  final int active;
  final bool isFavorite;
  final String createdAt;

  //this.category,
  Product(this.id,this.name,this.vendorName,this.images,this.price,this.discountPrice,this.quantity
      ,this.description,this.active,this.isFavorite,this.createdAt);

  Product.fromJson(Map<String,dynamic> json):
      id=json['id'],
      name=json['name'],
      vendorName=json['vendor']['name'],
      images=List<String>.from(json['photos']).toList(),
      price=json['price'],
      discountPrice=json['discount_price'],
      quantity=int.parse(json['capacity']),
      description=json['description'],
      // category=Category.fromJson(json['category']),
      active=json['is_active'],
      isFavorite=json['is_favourite'],
      createdAt=json['formatted_date'];
  
  static Future<List<Product>> getDummyProducts() async{
    Category category = Category(1, "Dairy", "http");
    Product product = Product(1, "Cheese","KFC", List.of(['https://i.picsum.photos/id/488/1772/1181.jpg?hmac=psl3qLyDefO6AYqU4TJQ8PNCjS8RdPiP_vRLB8WPVjY','https://i.picsum.photos/id/488/1772/1181.jpg?hmac=psl3qLyDefO6AYqU4TJQ8PNCjS8RdPiP_vRLB8WPVjY']), 3400, 0, 100, "Nice cheese", 1,false, "22/12/2021");
    Product product1 = Product(2, "Steak","Kings", List.of(['https://i.picsum.photos/id/488/1772/1181.jpg?hmac=psl3qLyDefO6AYqU4TJQ8PNCjS8RdPiP_vRLB8WPVjY','https://i.picsum.photos/id/488/1772/1181.jpg?hmac=psl3qLyDefO6AYqU4TJQ8PNCjS8RdPiP_vRLB8WPVjY']), 8000, 2, 60, "Nice meat", 1,true, "22/12/2021");
    Product product3 = Product(3, "Skim Milk","Dickson", List.of(['https://i.picsum.photos/id/488/1772/1181.jpg?hmac=psl3qLyDefO6AYqU4TJQ8PNCjS8RdPiP_vRLB8WPVjY','https://i.picsum.photos/id/488/1772/1181.jpg?hmac=psl3qLyDefO6AYqU4TJQ8PNCjS8RdPiP_vRLB8WPVjY']), 3000, 1, 200, "Nice milk", 1,false, "22/12/2021");

    await Future.delayed(const Duration(seconds: 2),(){});

    return List.of([product,product1,product3]);
  }
}