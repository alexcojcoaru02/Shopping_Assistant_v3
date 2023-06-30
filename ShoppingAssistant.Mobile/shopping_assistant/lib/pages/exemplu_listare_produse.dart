import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_assistant/models/product.dart';
import 'package:shopping_assistant/pages/product_page.dart';
import 'package:shopping_assistant/widgets/categories_widget.dart';
import 'package:shopping_assistant/widgets/product_sumary.dart';
import 'package:shopping_assistant/widgets/search_bar_widget.dart';

import '../providers/products_provider.dart';
import '../widgets/horisontal_product_list.dart';

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
        body: provider.error.isNotEmpty
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
    var size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        color: const Color(0xfff0f1f5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const SearchBarWidget(),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                width: double.infinity,
              ),
              SizedBox(
                height: 30,
                width: size.width > 800 ? 800 : size.width,
                child: Text(
                  "Produse alimentare",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                height: 360, // Ajustează înălțimea în funcție de nevoi
                child: ScrollableProductList(
                  products: productsProvider.products // Afișează produsele
                      .where((element) => element.category == ProductCategory.food)
                      .toList(),
                ),
              ),
              SizedBox(
                height: 30,
                width: size.width > 800 ? 800 : size.width,
                child: Text(
                  "Produse electronice și electrocasnice",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                height: 360, // Ajustează înălțimea în funcție de nevoi
                child: ScrollableProductList(
                  products: productsProvider.products // Afișează produsele
                      .where((element) => element.category == ProductCategory.electronics)
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
