import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';
import 'package:shopping_assistant/widgets/no_reviews_widget.dart';
import '../models/product.dart';
import '../providers/products_provider.dart';
import '../widgets/review_section.dart';

class ProductPage extends StatefulWidget {
  final String productId;

  const ProductPage({Key? key, required this.productId}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    final provider = Provider.of<ProductsProvider>(context, listen: false);
    provider.getDataFromAPI();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    Product product = ProductsProvider().products.where((element) => element.id == widget.productId).first;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MediaQuery.of(context).size.width > 600
                      ? Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * .5,
                              child: Image.network(
                                product.imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    product.description,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Average Price: ${calculateAveragePrice(product).toStringAsFixed(2)} Lei',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width * .7,
                                child: Image.network(
                                  product.imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  product.name,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  product.description,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Average Price: ${calculateAveragePrice(product).toStringAsFixed(2)} Lei',
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                  const SizedBox(height: 16),
                  const Text(
                    'Price History',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    child: buildPriceHistoryGraph(product),
                  ),
                  const SizedBox(height: 16),
                  product.reviews.isNotEmpty ? RatingSection(
                    productId: product.id,
                  ) : buildNoReviewsWidget(product.id, context)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double calculateAveragePrice(product) {
    if (product.priceHistory.isNotEmpty) {
      double sum = 0;
      for (var price in product.priceHistory) {
        sum += price.price;
      }
      return sum / product.priceHistory.length;
    }
    return 0;
  }

  Widget buildPriceHistoryGraph(product) {
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
