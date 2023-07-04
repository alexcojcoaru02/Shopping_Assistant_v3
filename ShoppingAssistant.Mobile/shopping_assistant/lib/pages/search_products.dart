import 'package:flutter/material.dart';
import 'package:shopping_assistant/models/product.dart';
import 'package:shopping_assistant/providers/products_provider.dart';
import 'package:shopping_assistant/widgets/custom_appbar.dart';

import '../widgets/product_sumary.dart';

class ProductGridPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Product> products = ProductsProvider().searchedProducts;

    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: const Color(0xfff0f1f5),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductSummary(
                productId: products[index].id,
                width: 200,
                height: 300,
                canAddToCart: true,
              );
            },
          ),
        ),
      ),
    );
  }
}
