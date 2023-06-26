import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_assistant/pages/product_page.dart';
import 'package:shopping_assistant/widgets/categories_widget.dart';
import 'package:shopping_assistant/widgets/product_sumary.dart';
import 'package:shopping_assistant/widgets/search_bar_widget.dart';

import '../providers/products_provider.dart';
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
    return Center(
      child: Container(
        color: Colors.grey[200],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 50,
            ),
            const SearchBarWidget(),
            const SizedBox(
              height: 10,
            ),
            Consumer<ProductsProvider>(
              builder: (context, provider, child) =>
                  CategoriesWidget(productsProvider: provider),
            ),
            Expanded(
              child: Consumer(
                builder: (
                  context,
                  ProductsProvider provider,
                  child,
                ) =>
                    ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: productsProvider.searchedProducts.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductPage(
                            productId:
                                productsProvider.searchedProducts[index].id,
                          ),
                        ),
                      );
                    },
                    child: ProductSummary(
                      productId: productsProvider.searchedProducts[index].id,
                      width: 200,
                      height: 300,
                      canAddToCart: true,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
