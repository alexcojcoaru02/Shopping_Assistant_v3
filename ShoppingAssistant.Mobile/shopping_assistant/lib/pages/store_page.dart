import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/store.dart';

class StorePage extends StatelessWidget {
  final Store store;

  const StorePage({required this.store});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(store.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ID: ${store.id}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Address: ${store.address}',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 8),
              Text(
                'Location: ${store.location}',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _launchURL(store.location);
                },
                child: const Text('Visit Online'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchURL(String address) async {
    final url = Uri.parse(address);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
