import 'package:flutter/material.dart';
import 'package:shopping_assistant/widgets/product_sumary.dart';

import '../models/product.dart';
import '../pages/product_page.dart';

class GirdProductsView extends StatelessWidget {
  List<Product> products;
  GirdProductsView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Numărul de coloane în grilă
        childAspectRatio:
            200 / 300, // Raportul de aspect pentru fiecare element
      ),
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
    );
  }
}
