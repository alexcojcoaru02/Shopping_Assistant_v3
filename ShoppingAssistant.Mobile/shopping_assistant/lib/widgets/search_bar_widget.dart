import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../services/product_service.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.search),
          const Text('Search product'),
          GestureDetector(
              child: const Icon(Icons.camera),
              onTap: () {
                scanBarcode();
              })
        ],
      ),
    );
  }
}

Future<void> scanBarcode() async {
  final productService = ProductService();

  String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
    "#ff6666",
    "Cancel",
    true,
    ScanMode.DEFAULT,
  );

  if (barcodeScanRes != '-1') {
    print('Barcode scanned: $barcodeScanRes');

    productService.getProductByBarcode(barcodeScanRes).then((product) {
      // Handle the product response
      print('Product: ${product.name}, Barcode: ${product.barcode}');
    }).catchError((error) {
      // Handle any errors that occur
      print('Error: $error');
    });
  } else {
    print('User cancelled the scan');
  }
}