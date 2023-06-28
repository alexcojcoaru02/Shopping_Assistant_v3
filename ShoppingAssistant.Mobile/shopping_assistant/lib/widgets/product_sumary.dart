import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

import '../models/product.dart';
import '../providers/products_provider.dart';

class ProductSummary extends StatelessWidget {
  final String productId;
  late Product product;
  final int width;
  final int height;
  final bool canAddToCart;

  ProductSummary(
      {Key? key,
      required this.productId,
      required this.width,
      required this.height,
      required this.canAddToCart})
      : super(key: key) {
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
        Card(
          child: SizedBox(
            width: width.toDouble(),
            height: height.toDouble(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: width.toDouble(),
                  height: height.toDouble() * .5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                SizedBox(
                  width: width.toDouble(),
                  height: height.toDouble() * .5,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            product.name,
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                          Text(
                            'Pretul mediu: ${averagePrice.toStringAsFixed(2)} lei',
                            style: const TextStyle(fontSize: 16),
                          ),
                          Center(
                            child: buildRatingSumary(
                              averageRating,
                              product.reviews.length,
                            ),
                          ),
                          canAddToCart
                              ? SizedBox(
                                  width: width.toDouble() * .9,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      ProductsProvider().addToCart(product);
                                    },
                                    icon: const Icon(Icons.shopping_cart),
                                    label: const Text('Adaugă în coș'),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
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
