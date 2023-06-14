import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_assistant/widgets/poduct_listing.dart';

import '../models/product.dart';
import '../providers/products_provider.dart';
import '../services/product_service.dart';
import '../utils/configuration.dart';
import '../widgets/categories_widget.dart';
import '../widgets/location_widget.dart';
import '../widgets/search_bar_widget.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    List<Product> productList = [];
    ProductService().getAllProducts().then((value) => productList = value);
    return ChangeNotifierProvider(
      create: (context) => ProductsProvider(),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      isDrawerOpen
                          ? IconButton(
                              icon: const Icon(Icons.arrow_back_ios),
                              onPressed: () {
                                setState(() {
                                  xOffset = 0;
                                  yOffset = 0;
                                  scaleFactor = 1;
                                  isDrawerOpen = false;
                                });
                              },
                            )
                          : IconButton(
                              icon: const Icon(Icons.menu),
                              onPressed: () {
                                setState(
                                  () {
                                    xOffset = 230;
                                    yOffset = 150;
                                    scaleFactor = 0.6;
                                    isDrawerOpen = true;
                                  },
                                );
                              },
                            ),
                      const LocationWidget(),
                      const CircleAvatar()
                    ],
                  ),
                ),
                const SearchBarWidget(),
                Consumer<ProductsProvider>(
                  builder: (context, provider, child) =>
                      CategoriesWidget(productsProvider: provider),
                ),
                const ProductsListing(),
                Container(
                  height: 240,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.orange[100],
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: shadowList,
                              ),
                              margin: const EdgeInsets.only(top: 50),
                            ),
                            Align(
                              child: Image.asset(
                                  'assets/images/products/iphone-14-pro.png'),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                          child: Container(
                        margin: const EdgeInsets.only(top: 60, bottom: 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: shadowList,
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20))),
                      ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
