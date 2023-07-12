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
          Builder(
            builder: (context) {
              final deviceWidth = MediaQuery.of(context).size.width;
              if (deviceWidth >= 600) {
                return IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    scrollController.animateTo(
                      scrollController.offset - 500,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                );
              } else {
                return const SizedBox
                    .shrink();
              }
            },
          ),
          SizedBox(
            width: size.width > 600 ? size.width - 200 : size.width - 40,
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
          Builder(
            builder: (context) {
              final deviceWidth = MediaQuery.of(context).size.width;
              if (deviceWidth >= 600) {
                return IconButton(
                  icon: const Icon(Icons.arrow_forward_ios_outlined),
                  onPressed: () {
                    scrollController.animateTo(
                      scrollController.offset + 500,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                );
              } else {
                return const SizedBox
                    .shrink(); // Return an empty widget if not visible
              }
            },
          ),
        ],
      ),
    );
  }
}
