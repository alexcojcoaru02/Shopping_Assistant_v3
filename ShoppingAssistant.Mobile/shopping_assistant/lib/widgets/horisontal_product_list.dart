import 'package:flutter/material.dart';
import 'package:shopping_assistant/widgets/product_sumary.dart';

import '../models/product.dart';
import '../pages/product_page.dart';

class ScrollableProductList extends StatelessWidget {
  final List<Product> products;

  const ScrollableProductList({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();

    return Expanded(
      child: Stack(
        children: [
          Container(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductPage(
                        productId: products[index].id,
                      ),
                    ),
                  );
                },
                child: ProductSummary(
                  productId: products[index].id,
                  width: 200,
                  height: 300,
                  canAddToCart: true,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                scrollController.animateTo(
                  scrollController.offset - 100,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: IconButton(
              icon: const Icon(Icons.arrow_forward_ios_outlined),
              onPressed: () {
                scrollController.animateTo(
                  scrollController.offset + 100,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
