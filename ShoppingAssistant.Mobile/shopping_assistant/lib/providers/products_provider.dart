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

  static final ProductsProvider _instance = ProductsProvider._internal();

  factory ProductsProvider() {
    return _instance;
  }

  ProductsProvider._internal();

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

  search(String text) async {
    searchText = text;
    if (text.isEmpty) {
      searchedProducts = products;
      notifyListeners();
    } else {
      try {
        isLoading = true;
        notifyListeners();
        final response = await http.get(Uri.parse('$_baseUrl/hint?hint=$text'));
        if (response.statusCode == 200) {
          final productsJson = jsonDecode(response.body) as List<dynamic>;
          searchedProducts = productsJson
              .map((productJson) => Product.fromJson(productJson))
              .toList();
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
  }

  searchBaracode(String barcode) async {
    if (barcode.isEmpty) {
      searchedProducts = products;
      notifyListeners();
    } else {
      try {
        isLoading = true;
        notifyListeners();
        final response = await http.get(Uri.parse('$_baseUrl/barcode?barcode=$barcode'));
        if (response.statusCode == 200) {
          final productsJson = jsonDecode(response.body) as List<dynamic>;
          searchedProducts = productsJson
              .map((productJson) => Product.fromJson(productJson))
              .toList();
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
  }

  filterByCategory(int category) {
    if (category == -1) {
      searchedProducts = products;
      notifyListeners();
      return;
    }
    searchedProducts = products
        .where((product) => product.category == getCategoryFromInt(category))
        .toList();
    notifyListeners();
  }

  //
}
