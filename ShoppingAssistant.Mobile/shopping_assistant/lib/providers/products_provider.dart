import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopping_assistant/models/product.dart';
import 'package:http/http.dart' as http;

class ProductsProvider extends ChangeNotifier {
  final _baseUrl =
      'https://alex-shopping-assistant.azurewebsites.net/api/product';
  final _baseUrlLocal = 'https://localhost:7014/api/product';

  bool isLoading = true;
  String error = '';
  List<Product> products = [];
  List<Product> searchedProducts = [];
  String searchText = '';
  List<String> wishListProducts = [];

  static final ProductsProvider _instance = ProductsProvider._internal();

  static ProductsProvider get instance => _instance;

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

  Future<void> addReview(
    String productId,
    Review reviewInput,
    BuildContext context,
  ) async {
    try {
      products
          .firstWhere((product) => product.id == productId)
          .reviews
          .add(reviewInput);
      final url = '$_baseUrl/$productId/reviews';
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(reviewInput),
      );

      if (response.statusCode == 200) {
        getDataFromAPI();
        notifyListeners();
        Fluttertoast.showToast(
          msg: "Review added successfully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
      } else {
        Fluttertoast.showToast(
          msg: "A aparut o eroare",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } on Exception catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> editReview(
    String productId,
    Review reviewInput,
    BuildContext context,
  ) async {
    try {
      var userOldReview = products
          .firstWhere((product) => product.id == productId)
          .reviews
          .firstWhere((review) => review.userName == reviewInput.userName);
      userOldReview = reviewInput;
      final url = '$_baseUrl/$productId/reviews';
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(reviewInput),
      );

      if (response.statusCode == 200) {
        getDataFromAPI();
        notifyListeners();
        Fluttertoast.showToast(
          msg: "Review added successfully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
      } else {
        Fluttertoast.showToast(
          msg: "A aparut o eroare",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } on Exception catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void toggleFavorite(Product product) {
    bool exists = wishListProducts.any((p) => p == product.id);
    var pro = products.firstWhere((p) => p.id == product.id);
    if (!exists) {
      wishListProducts.add(product.id);
      notifyListeners();
    } else {
      wishListProducts.remove(product.id);
      notifyListeners();
    }
  }

  search(BuildContext context, String text) async {
    searchText = text;
    if (text.isEmpty) {
      searchedProducts = products;
      notifyListeners();
    } else {
      try {
        isLoading = true;
        notifyListeners();
        final response = await http.get(
          Uri.parse('$_baseUrl/hint?hint=$text'),
        );
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

        Navigator.pushNamed(context, '/searchPage');
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
        final response =
            await http.get(Uri.parse('$_baseUrl/barcode?barcode=$barcode'));
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
