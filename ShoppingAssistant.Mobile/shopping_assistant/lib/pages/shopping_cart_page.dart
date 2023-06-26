import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../utils/configuration.dart';

class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double averagePrice =
        calculateAveragePrice(Provider.of<ProductsProvider>(context).cartProducts);

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
                    return ListTile(
                      title: Text(product.name),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          productsProvider.removeFromCart(product);
                        },
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Average Price: ${averagePrice.toStringAsFixed(2)}',
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
