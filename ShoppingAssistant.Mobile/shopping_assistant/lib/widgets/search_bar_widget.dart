import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/product.dart';
import '../pages/add_product_page.dart';
import '../pages/product_page.dart';
import '../providers/products_provider.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  ProductsProvider productsProvider = ProductsProvider();
  TextEditingController _textFieldController = TextEditingController();
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _initSpeech();
    _textFieldController = TextEditingController();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize(
      onError: _onSpeechError,
    );
    if (_speechEnabled) {
      final status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {}
    }
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      _textFieldController.text = _lastWords;

      if (result.finalResult) {
        _stopListening();
        productsProvider.search(context, _lastWords);
      }
    });
    _resetTimer();
  }

  void _resetTimer() {
    _timer?.cancel();

    _timer = Timer(const Duration(seconds: 2), () {
      if (_speechToText.isListening) {
        _stopListening();
      }
    });
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechError(SpeechRecognitionError error) {
    print('Speech recognition error: ${error.errorMsg}');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 1100),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
        child: TextField(
          controller: _textFieldController,
          onSubmitted: (value) {
            productsProvider.search(context, value);
          },
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            prefixIcon: const Icon(Icons.search),
            hintText: 'Search product',
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: _speechToText.isNotListening
                      ? _startListening
                      : _stopListening,
                  child: Icon(
                    Icons.mic,
                    color:
                        !_speechToText.isListening ? Colors.grey : Colors.red,
                  ),
                ),
                if (MediaQuery.of(context).size.width < 600) ...[
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      scanBarcode(context);
                    },
                    child: const CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.grey,
                      child: Icon(
                        Icons.qr_code_scanner,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> scanBarcode(BuildContext context) async {
  final productPorvider = ProductsProvider();
  Product searchedProduct;

  String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
    "#ff6666",
    "Cancel",
    true,
    ScanMode.DEFAULT,
  );

  if (barcodeScanRes != '-1') {
    productPorvider.searchBaracode(barcodeScanRes).then((product) {
      searchedProduct = product;
      if (searchedProduct.id != '') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductPage(
              productId: searchedProduct.id,
            ),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddProductPage(barcode: barcodeScanRes),
          ),
        );
      }
    }).catchError((error) {
      print('Error: $error');
    });
  } else {
    print('User cancelled the scan');
  }
}
