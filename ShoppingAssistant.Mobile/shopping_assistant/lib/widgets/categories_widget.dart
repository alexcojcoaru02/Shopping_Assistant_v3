import 'package:flutter/material.dart';

import '../utils/configuration.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({super.key});

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Container(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: shadowList,
                      borderRadius: BorderRadius.circular(10)),
                  child: Image.asset(
                    categories[index]['iconPath'],
                    height: 50,
                    width: 50,
                    color: Colors.grey[700],
                  ),
                ),
                Text(categories[index]['name'])
              ],
            ),
          );
        },
      ),
    );
  }
}
