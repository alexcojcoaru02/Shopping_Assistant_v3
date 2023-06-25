import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

import '../models/product.dart';
import '../providers/products_provider.dart';

class ProductSummary extends StatelessWidget {
  final String productId;
  late Product product;

  ProductSummary({Key? key, required this.productId}) : super(key: key) {
    product = ProductsProvider()
        .products
        .firstWhere((element) => element.id == productId);
  }

  @override
  Widget build(BuildContext context) {
    double averagePrice = calculateAveragePrice();
    double averageRating = calculateAverageRating();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Adauga un review pentru: ',
          textAlign: TextAlign.left,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Card(
          child: SizedBox(
            width: 300,
            height: 400,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          product.name,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Pretul mediu: ${averagePrice.toStringAsFixed(2)} lei',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Center(
                          child: buildRatingSumary(
                            averageRating,
                            product.reviews.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  double calculateAveragePrice() {
    if (product.priceHistory.isNotEmpty) {
      double sum = 0;
      product.priceHistory.forEach((priceHistory) {
        sum += priceHistory.price;
      });
      return sum / product.priceHistory.length;
    } else {
      return 0;
    }
  }

  double calculateAverageRating() {
    if (product.reviews.isNotEmpty) {
      double sum = 0;
      product.reviews.forEach((review) {
        sum += review.rating;
      });
      return sum / product.reviews.length;
    } else {
      return 0;
    }
  }
}

Widget buildRatingSumary(double averageRating, int reviewCount) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RatingBarIndicator(
            rating: averageRating,
            itemCount: 5,
            itemSize: 20.0,
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            averageRating.toStringAsFixed(2),
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            '($reviewCount)',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    ],
  );
}
