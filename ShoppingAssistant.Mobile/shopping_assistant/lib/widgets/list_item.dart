import 'package:flutter/material.dart';
import 'package:shopping_assistant/models/product.dart';

class ListItem extends StatelessWidget {
  const ListItem({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(
          "https://auchan.vtexassets.com/arquivos/ids/161311/ciocolata-milka-cu-oreo-100-g-8950825713694.jpg?v=637981755884530000",
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
      ),
    );
  }
}
