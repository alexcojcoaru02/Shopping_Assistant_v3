class Product {
  String name;
  String barcode;
  String description;
  ProductCategory category;
  double price;
  String imageUrl;
  int stockQuantity;
  int storeId;

  Product(
    this.name,
    this.barcode,
    this.description,
    this.category,
    this.price,
    this.imageUrl,
    this.stockQuantity,
    this.storeId,
  );  

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      json['name'],
      json['barcode'],
      json['description'],
      ProductCategory.values.firstWhere((e) => e.toString() == 'ProductCategory.' + json['category']),
      json['price'],
      json['imageUrl'],
      json['stockQuantity'],
      json['storeId'],);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'barcode': barcode,
      'description': description,
      'category': category.toString().split('.').last,
      'price': price,
      'imageUrl': imageUrl,
      'stockQuantity': stockQuantity,
      'storeId': storeId,
    };
  }
}

enum ProductCategory {
  electronics,
  clothing,
  beauty,
  food,
  home,
  sports,
}
