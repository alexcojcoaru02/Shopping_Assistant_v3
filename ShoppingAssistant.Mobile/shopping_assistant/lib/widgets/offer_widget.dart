import 'package:flutter/material.dart';
import 'package:shopping_assistant/utils/configuration.dart';
import 'package:shopping_assistant/widgets/responsive_layout.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/configuration.dart';

import '../models/product.dart';
import '../models/store.dart';
import 'package:intl/intl.dart';
import '../pages/store_page.dart';

class OfferCard extends StatelessWidget {
  final PriceHistory price;
  final Store store;

  const OfferCard({
    Key? key,
    required this.price,
    required this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd.MM.yyyy HH:mm').format(price.dateTime);
    var size = MediaQuery.of(context).size;

    return SizedBox(
      width: 500,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 4,
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ResponsiveLayoutWidget(
                crossAxisAlignment: size.width < 600
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                child1: Text(
                  'Preț: ${price.price.toStringAsFixed(2)} Lei',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child2: Text(
                  'Actualizat: $formattedDate',
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              ResponsiveLayoutWidget(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                child1: Text(
                  store.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child2: ElevatedButton(
                  onPressed: () {
                    _launchURL(store.location);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    backgroundColor: primaryGreen,
                  ),
                  child: const Text('Vizitează'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _launchURL(String address) async {
  final url = Uri.parse(address);
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
