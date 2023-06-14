import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../models/product.dart';

class ProductPage extends StatelessWidget {
  final Product product;

  const ProductPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display product image
            Container(
              height: 200,
              width: double.infinity,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display product name
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Display product description
                  Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  // Display average price
                  Text(
                    'Average Price: ${calculateAveragePrice().toStringAsFixed(2)} Lei',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Display price history graph
                  const Text(
                    'Price History',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: 200,
                    child: buildPriceHistoryGraph(),
                  ),
                  const SizedBox(height: 16),
                  // Display reviews
                  Text(
                    'Reviews (${product.reviews.length})',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: product.reviews.length,
                    itemBuilder: (context, index) {
                      final review = product.reviews[index];
                      return ListTile(
                        title: Text('Rating: ${review.rating}'),
                        subtitle: Text(review.comment),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double calculateAveragePrice() {
    if (product.priceHistory.isNotEmpty) {
      double sum = 0;
      for (var price in product.priceHistory) {
        sum += price.price;
      }
      return sum / product.priceHistory.length;
    }
    return 0;
  }

  Widget buildPriceHistoryGraph() {
    List<charts.Series<PriceHistory, DateTime>> seriesList = [
      charts.Series<PriceHistory, DateTime>(
        id: 'Price',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (PriceHistory price, _) => price.dateTime,
        measureFn: (PriceHistory price, _) => price.price,
        data: product.priceHistory,
      ),
    ];

    return charts.TimeSeriesChart(
      seriesList,
      animate: true,
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }
}
