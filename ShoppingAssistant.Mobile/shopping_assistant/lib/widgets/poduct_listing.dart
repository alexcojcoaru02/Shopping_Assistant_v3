import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_assistant/providers/products_provider.dart';

class ProductsListing extends StatefulWidget {
  const ProductsListing({super.key});

  @override
  State<ProductsListing> createState() => _ProductsListing();
}

class _ProductsListing extends State<ProductsListing> {
  @override
  void initState() {
    final provider = Provider.of<ProductsProvider>(context, listen: false);
    provider.getDataFromAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('build called');
    final provider = Provider.of<ProductsProvider>(context);
    return Scaffold(
      body: provider.isLoading
          ? getLoadingUI(context)
          : provider.error.isNotEmpty
              ? getErrorUI(provider.error)
              : getBodyUI(),
    );
  }

  Widget getLoadingUI(BuildContext context) {
    return const Text(
      'Loading...',
      style: TextStyle(fontSize: 20, color: Colors.blue),
    );
  }

  Widget getErrorUI(String error) {
    return Center(
      child: Text(
        error,
        style: const TextStyle(color: Colors.red, fontSize: 22),
      ),
    );
  }

  Widget getBodyUI() {
    final provider = Provider.of<ProductsProvider>(context, listen: false);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              suffixIcon: const Icon(Icons.search),
            ),
          ),
        ),
        Expanded(
          child: Consumer(
            builder: (context, ProductsProvider productsProvider, child) =>
                ListView.builder(
              itemCount: productsProvider.products.length,
              itemBuilder: (context, index) => ListTile(
                leading: const CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.white,
                ),
                title: Text(productsProvider.products[index].name),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
