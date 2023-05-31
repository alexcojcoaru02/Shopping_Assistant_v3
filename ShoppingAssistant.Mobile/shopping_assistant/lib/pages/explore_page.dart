import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:shopping_assistant/pages/scan_barcode.dart';

import '../services/product_service.dart';
import '../utils/configuration.dart';

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
    return Scaffold(
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
                              setState(() {
                                xOffset = 230;
                                yOffset = 150;
                                scaleFactor = 0.6;
                                isDrawerOpen = true;
                              });
                            }),
                    Column(
                      children: [
                        const Text('Location'),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: primaryGreen,
                            ),
                            const Text('Bucuresti'),
                          ],
                        ),
                      ],
                    ),
                    const CircleAvatar()
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                margin:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
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
              ),
              Container(
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
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>Screen2()));
                },
                child: Container(
                  height: 240,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.blueGrey[300],
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: shadowList,
                              ),
                              margin: const EdgeInsets.only(top: 50),
                            ),
                            Align(
                              child: Hero(
                                  tag: 1,
                                  child: Image.asset(
                                      'assets/images/products/cp_calcidin600.png')),
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
              ),
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

    productService.getProductByBarcode(barcodeScanRes)
    .then((product) {
      // Handle the product response
      print('Product: ${product.name}, Barcode: ${product.barcode}');
    })
    .catchError((error) {
      // Handle any errors that occur
      print('Error: $error');
    });
  } else {
    print('User cancelled the scan');
  }
}