import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shopping_assistant/models/product.dart';
import 'package:http/http.dart' as http;

class ProductsProvider extends ChangeNotifier {
  final _baseUrl =
      'https://alex-shopping-assistant.azurewebsites.net/api/product';

  bool isLoading = true;
  String error = '';
  List<Product> products = [];
  List<Product> searchedProducts = [];
  String searchText = '';

  //
  getDataFromAPI() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));
      if (response.statusCode == 200) {
        final productsJson = jsonDecode(response.body) as List<dynamic>;
        products = productsJson
            .map((productJson) => Product.fromJson(productJson))
            .toList();
        searchedProducts = products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  search(String text) {
    searchText = text;
    if (text.isEmpty) {
      searchedProducts = products;
      notifyListeners();
    } else {
      searchedProducts = products
          .where((product) =>
              product.name.toLowerCase().contains(text.toLowerCase()))
          .toList();
      notifyListeners();
    }
  }
  
  //
}
