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
    var size = MediaQuery.of(context).size;

    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              scrollController.animateTo(
                scrollController.offset - 500,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
          ),
          SizedBox(
            width: size.width - 200,
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
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios_outlined),
            onPressed: () {
              scrollController.animateTo(
                scrollController.offset + 500,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
          ),
        ],
      ),
    );
  }
}
