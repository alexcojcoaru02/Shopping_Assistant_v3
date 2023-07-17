import 'package:flutter/material.dart';

class ProductNotFoundPage extends StatelessWidget {
  final String barcode;

  const ProductNotFoundPage({super.key, required this.barcode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff0f1f5),
      appBar: AppBar(
        title: const Text('Produsul nu a fost găsit'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(19.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Ne pare rău!',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Produsul cu codul de bare $barcode nu face parte din baza de date.',
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
