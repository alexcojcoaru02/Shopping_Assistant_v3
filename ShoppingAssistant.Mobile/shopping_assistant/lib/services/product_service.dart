import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product.dart';

class ProductService {
  final _baseUrl = 'https://alex-shopping-assistant.azurewebsites.net/api/product';

  Future<List<Product>> getAllProducts() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      final productsJson = jsonDecode(response.body) as List<dynamic>;
      return productsJson.map((productJson) => Product.fromJson(productJson)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<Product> getProduct(String id) async {
    final response = await http.get(Uri.parse('$_baseUrl/$id'));
    if (response.statusCode == 200) {
      final productJson = jsonDecode(response.body) as Map<String, dynamic>;
      return Product.fromJson(productJson);
    } else {
      throw Exception('Failed to load product with id=$id');
    }
  }

  

  Future<Product> getProductByBarcode(String barcode) async {
    final response = await http.get(Uri.parse('$_baseUrl/barcode?barcode=$barcode'));
    if (response.statusCode == 200) {
      final productJson = jsonDecode(response.body) as Map<String, dynamic>;
      return Product.fromJson(productJson);
    } else {
      throw Exception('Failed to load product with barcode=$barcode');
    }
  }
}