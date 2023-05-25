import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanBarcode extends StatelessWidget {
  const ScanBarcode({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Barcode Scanner App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Barcode Scanner'),
          backgroundColor: Colors.cyan,
        ),
        drawer: const NavigationDrawer(children: [],),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              scanBarcode(); // call the scanBarcode function here
            },
            child: const Text('Scan Barcode'),
          ),
        ),
      ),
    );
  }
}
Future<void> scanBarcode() async {
  String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
    "#ff6666",
    "Cancel",
    true,
    ScanMode.DEFAULT,
  );

  if (barcodeScanRes != '-1') {
    print('Barcode scanned: $barcodeScanRes');
  } else {
    print('User cancelled the scan');
  }
}