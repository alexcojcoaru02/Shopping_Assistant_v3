class Product {
  String id;
  String name;
  String barcode;
  String description;
  ProductCategory category;
  String imageUrl;
  List<PriceHistory> priceHistory;
  List<Review> reviews;

  Product(
    this.id,
    this.name,
    this.barcode,
    this.description,
    this.category,
    this.imageUrl,
    this.priceHistory,
    this.reviews,
  );

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        name = json['name'] as String,
        barcode = json['barcode'] as String,
        description = json['description'] as String,
        category = getCategoryFromInt(json['category'] as int),
        imageUrl = json['imageUrl'] as String,
        priceHistory = (json['priceHistory'] as List<dynamic>)
            .map((e) => PriceHistory.fromJson(e as Map<String, dynamic>))
            .toList(),
        reviews = (json['reviews'] as List<dynamic>)
            .map((e) => Review.fromJson(e as Map<String, dynamic>))
            .toList();
}

class PriceHistory {
  double price;
  String storeId;
  DateTime dateTime;

  PriceHistory(
    this.price,
    this.storeId,
    this.dateTime,
  );

  PriceHistory.fromJson(Map<String, dynamic> json)
      : price = json['price'] as double,
        storeId = json['storeId'] as String,
        dateTime = DateTime.parse(json['dateTime'] as String);
}

class Review {
  int rating;
  String comment;
  String userId;
  String userName;
  DateTime dateTime;

  Review(
    this.rating,
    this.comment,
    this.userId,
    this.userName,
    this.dateTime,
  );

  Review.fromJson(Map<String, dynamic> json)
      : rating = json['rating'] as int,
        comment = json['comment'] as String,
        userId = json['userId'] as String,
        userName = json['userName'] as String,
        dateTime = DateTime.parse(json['dateTime'] as String);

  Map<String, dynamic> toJson() {
    return {
      'rating': rating,
      'comment': comment,
      'userId': userId,
      'userName': userName,
      'dateTime': dateTime.toIso8601String(),
    };
  }
}

ProductCategory getCategoryFromInt(int value) {
  if (value >= 0 && value < ProductCategory.values.length) {
    return ProductCategory.values[value];
  } else {
    throw Exception('Invalid enum value');
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
