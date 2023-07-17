import 'package:flutter/material.dart';
import 'package:shopping_assistant/providers/products_provider.dart';
import 'package:provider/provider.dart';

import '../utils/configuration.dart';

class AddProductPage extends StatelessWidget {
  final String barcode;

  AddProductPage({required this.barcode});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    TextEditingController storeController = TextEditingController();
    ProductsProvider productProvider = Provider.of<ProductsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Product Name',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(
                labelText: 'Price',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: storeController,
              decoration: const InputDecoration(
                labelText: 'Store',
              ),
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryGreen,
              ),
              onPressed: () {
                String name = nameController.text;
                double price = double.parse(priceController.text);
                String store = storeController.text;

                Navigator.pop(context);
              },
              child: const Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}
