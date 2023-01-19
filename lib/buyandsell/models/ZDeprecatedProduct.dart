import 'dart:convert';

class DeprecatedProduct {
  final String id;
  final String name;
  final double price;
  final String description;
  final List<String> imageUrl;
  final String sellerId;
  final String sellerName;
  final bool isAvailable;

  DeprecatedProduct({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.sellerId,
    required this.sellerName,
    required this.isAvailable,
  });

  factory DeprecatedProduct.fromJson(Map<String, dynamic> json) {
    return DeprecatedProduct(
        id: json['id'],
        name: json['name'],
        price: json['price'],
        description: json['description'],
        imageUrl: List<String>.from(json['imageUrl']),
        sellerId: json['sellerId'],
        sellerName: json['sellerName'],
        isAvailable: json['isAvailable']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'imageUrl': imageUrl,
      'sellerId': sellerId,
      'sellerName': sellerName,
      'isAvailable': isAvailable,
    };
  }
}

List<DeprecatedProduct> productsFromJson(String jsonString) {
  final jsonData = json.decode(jsonString);
  return List<DeprecatedProduct>.from(
    jsonData.map((x) => DeprecatedProduct.fromJson(x)),
  );
}
