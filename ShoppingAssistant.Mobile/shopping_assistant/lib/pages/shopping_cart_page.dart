import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_assistant/widgets/list_item.dart';

import '../models/product.dart';
import '../providers/products_provider.dart';
import '../utils/configuration.dart';

class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: Consumer<ProductsProvider>(
        builder: (context, productsProvider, _) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: productsProvider.cartProducts.length,
                  itemBuilder: (context, index) {
                    final product = productsProvider.cartProducts[index];
                    return ListItem(product: product);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Average Total Price: ${calculeazatotal(Provider.of<ProductsProvider>(context).cartProducts).toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

calculeazatotal(List<Product> cartProducts) {
  double total = 0;
  cartProducts.forEach((product) {
    total += calculeazaPretMediuProdus(product);
  });
  return total;
}

calculeazaPretMediuProdus(Product product) {
  double total = 0;
  for (var i = 0; i < product.priceHistory.length; i++) {
    total += product.priceHistory[i].price;
  }
  return total / product.priceHistory.length;
}