import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../utils/configuration.dart';

class CategoriesWidget extends StatefulWidget {
  final ProductsProvider productsProvider;
  const CategoriesWidget({Key? key, required this.productsProvider})
      : super(key: key);

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  int selectedCategoryIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                if (selectedCategoryIndex == index) {
                  selectedCategoryIndex = -1; // Deselect category
                } else {
                  selectedCategoryIndex = index;
                }
                  filterByCategory(widget.productsProvider,
                      selectedCategoryIndex);
              });
            },
            child: Container(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                      color: selectedCategoryIndex == index
                          ? Colors.blue
                          : Colors.white,
                      boxShadow: shadowList,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset(
                      categories[index]['iconPath'],
                      height: 50,
                      width: 50,
                      color: Colors.grey[700],
                    ),
                  ),
                  Text(categories[index]['name']),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

void filterByCategory(ProductsProvider productsProvider, int categoryIndex) {
  productsProvider.filterByCategory(categoryIndex);
}
