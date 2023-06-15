import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../pages/product_page.dart';
import '../providers/products_provider.dart';
import '../services/product_service.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final productsProvider = ProductsProvider();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: TextField(
        onSubmitted: (value) {
          productsProvider.search(value);
        },
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          prefixIcon: const Icon(Icons.search),
          hintText: 'Search product',
          suffixIcon: GestureDetector(
            onTap: scanBarcode,
            child: const Icon(Icons.camera),
          ),
        ),
      ),
    );
  }
}

Future<void> scanBarcode() async {
  final productPorvider = ProductsProvider();

  String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
    "#ff6666",
    "Cancel",
    true,
    ScanMode.DEFAULT,
  );

  if (barcodeScanRes != '-1') {
    print('Barcode scanned: $barcodeScanRes');

    productPorvider.searchBaracode(barcodeScanRes).then((product) {
      
    }).catchError((error) {
      print('Error: $error');
    });
  } else {
    print('User cancelled the scan');
  }
}
