import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/products_provider.dart';
import '../utils/configuration.dart';
import '../widgets/list_item.dart';

class ExempluListare extends StatefulWidget {
  const ExempluListare({super.key});

  @override
  State<ExempluListare> createState() => _ExempluListareState();
}

class _ExempluListareState extends State<ExempluListare> {
  @override
  void initState() {
    final provider = Provider.of<ProductsProvider>(context, listen: false);
    provider.getDataFromAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductsProvider>(context);

    return ChangeNotifierProvider(
      create: (context) => ProductsProvider(),
      child: Scaffold(
        body: provider.isLoading
            ? getLoadingUI(context)
            : provider.error.isNotEmpty
                ? getErrorUI(provider.error)
                : getBodyUI(provider),
      ),
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

  Widget getBodyUI(ProductsProvider productsProvider) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              productsProvider.search(value);
            },
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
            builder: (context, ProductsProvider provider, child) =>
                ListView.builder(
              itemCount: productsProvider.searchedProducts.length,
              itemBuilder: (context, index) => ListItem(product: productsProvider.searchedProducts[index],)            ),
          ),
        ),
      ],
    );
  }
}
