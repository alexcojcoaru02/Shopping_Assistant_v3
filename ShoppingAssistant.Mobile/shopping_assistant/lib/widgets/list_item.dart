import 'package:flutter/material.dart';
import 'package:shopping_assistant/models/product.dart';
import 'package:shopping_assistant/pages/product_page.dart';

import '../providers/products_provider.dart';

class ListItem extends StatelessWidget {
  const ListItem({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductPage(productId: product.id),
            ),
          );
        },
        leading: Image.network(
          product.imageUrl,
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
        title: Text(product.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.description),
            Text(
              'Price: ${product.priceHistory.first.price.toStringAsFixed(2)} Lei',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            ProductsProvider().toggleFavorite(product);
          },
        ),
      ),
    );
  }
}
