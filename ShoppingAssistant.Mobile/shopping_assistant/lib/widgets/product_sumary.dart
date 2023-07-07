import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/products_provider.dart';

class ProductSummary extends StatefulWidget {
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
  State<ProductSummary> createState() => _ProductSummaryState();
}

class _ProductSummaryState extends State<ProductSummary> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProductsProvider>(context, listen: false);
    setState(() {
      isFavorite = provider.wishListProducts.contains(widget.productId);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final provider = Provider.of<ProductsProvider>(context);
    setState(() {
      isFavorite = provider.wishListProducts.contains(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    double averagePrice = calculateAveragePrice();
    double averageRating = calculateAverageRating();

    Product product = ProductsProvider()
        .products
        .firstWhere((element) => element.id == widget.productId);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          child: SizedBox(
            width: widget.width.toDouble(),
            height: widget.height.toDouble(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer<ProductsProvider>(
                  builder: (context, productProvider, _) => Stack(
                    children: [
                      SizedBox(
                        width: widget.width.toDouble(),
                        height: widget.height.toDouble() * .5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            widget.product.imageUrl,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            setState(() {
                              isFavorite = !isFavorite;
                              productProvider.toggleFavorite(product);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: widget.width.toDouble(),
                  height: widget.height.toDouble() * .5,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            widget.product.name,
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
                              widget.product.reviews.length,
                            ),
                          ),
                          widget.canAddToCart
                              ? const SizedBox.shrink()
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
    if (widget.product.priceHistory.isNotEmpty) {
      double sum = 0;
      widget.product.priceHistory.forEach((priceHistory) {
        sum += priceHistory.price;
      });
      return sum / widget.product.priceHistory.length;
    } else {
      return 0;
    }
  }

  double calculateAverageRating() {
    if (widget.product.reviews.isNotEmpty) {
      double sum = 0;
      widget.product.reviews.forEach((review) {
        sum += review.rating;
      });
      return sum / widget.product.reviews.length;
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
