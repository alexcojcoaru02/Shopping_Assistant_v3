import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_assistant/pages/store_page.dart';
import 'package:shopping_assistant/widgets/list_item.dart';

import '../models/product.dart';
import '../models/store.dart';
import '../providers/products_provider.dart';

class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Product> products = [];

    String mostFrequentStoreId = findMostFrequentStoreId(products);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: Consumer<ProductsProvider>(
        builder: (context, productsProvider, _) {
          var wishListProducts = productsProvider.products
              .where((element) =>
                  productsProvider.wishListProducts.contains(element.id))
              .toList();
          Store store = productsProvider.store;

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: wishListProducts.length,
                  itemBuilder: (context, index) {
                    final product = wishListProducts[index];
                    return ListItem(product: product);
                  },
                ),
              ),
              wishListProducts.isEmpty
                  ? const SizedBox.shrink()
                  : const Text(
                      "Poti gasi majoritatea produselor la un pret avantajos la magazinul:",
                    ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(store.name),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StorePage(store: store),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    child: const Text('Vizitează'),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Average Total Price: ${calculeazatotal(wishListProducts).toStringAsFixed(2)}',
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

String findMostFrequentStoreId(List<Product> products) {
  Map<String, int> countMap = {};
  int maxCount = 0;
  String mostFrequentStoreId = '';

  for (var product in products) {
    for (var priceHistory in product.priceHistory) {
      String storeId = priceHistory.storeId;
      countMap[storeId] = (countMap[storeId] ?? 0) + 1;
      if (countMap[storeId]! > maxCount) {
        maxCount = countMap[storeId]!;
        mostFrequentStoreId = storeId;
      }
    }
  }

  return mostFrequentStoreId;
}
