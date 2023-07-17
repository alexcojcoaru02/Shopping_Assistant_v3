import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shopping_assistant/widgets/no_reviews_widget.dart';
import '../models/product.dart';
import '../models/store.dart';
import '../providers/products_provider.dart';
import '../utils/configuration.dart';
import '../widgets/add_price.dart';
import '../widgets/eumorphic_button.dart';
import '../widgets/offer_widget.dart';
import '../widgets/rating_section.dart';
import '../widgets/responsive_layout.dart';

class ProductPage extends StatefulWidget {
  final String productId;

  const ProductPage({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool showOffers = false;

  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProductsProvider>(context, listen: false);
    isFavorite = provider.wishListProducts.contains(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    Product product = ProductsProvider()
        .products
        .where((element) => element.id == widget.productId)
        .first;

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryGreen,
        title: Text(product.name),
      ),
      body: Consumer<ProductsProvider>(
        builder: (context, productsProvider, child) => Container(
          color: const Color(0xfff0f1f5),
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ResponsiveLayoutWidget(
                      child1: SizedBox(
                        width: size.width > 1200
                            ? 600
                            : size.width > 600
                                ? size.width * .5
                                : size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(2, 2),
                                  blurRadius: 20,
                                )
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                product.imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      child2: SizedBox(
                        width: size.width > 1200
                            ? 600
                            : size.width > 600
                                ? size.width * .5
                                : size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
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
                              const SizedBox(height: 16),
                              Text(
                                'Minimum Price: ${calculateMinimumPrice(product).toStringAsFixed(2)} Lei',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryGreen,
                                ),
                                onPressed: () async {
                                  var ids = product.priceHistory
                                      .map((history) => history.storeId)
                                      .toList();
                                  await productsProvider.getStoresByIds(ids);

                                  setState(() {
                                    showOffersDialog(context, product);
                                  });
                                },
                                child: const Text('Verifică oferte'),
                              ),
                              const SizedBox(height: 16),
                              NeumorphicButton(
                                onPressed: () {
                                  var product = productsProvider.products
                                      .where((product) =>
                                          product.id == widget.productId)
                                      .first;
                                  productsProvider.toggleFavorite(product);
                                  setState(() {
                                    isFavorite = !isFavorite;
                                  });
                                },
                                isFavorite: isFavorite,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Daca ai gasit un pret mai bun, te rugam sa ne anunti!',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryGreen,
                                ),
                                onPressed: () async {
                                  var ids = product.priceHistory
                                      .map((history) => history.storeId)
                                      .toList();
                                  await productsProvider.getStoresByIds(ids);
                                  showAddPriceDialog(context,
                                      productsProvider.stores, product.id);
                                },
                                child: const Text('Adauga pret'),
                              ),
                            ],
                          ),
                        ),
                      ),
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
                    product.reviews.isNotEmpty
                        ? RatingSection(
                            productId: product.id,
                          )
                        : buildNoReviewsWidget(product.id, context),
                  ],
                ),
              ),
            ),
          ),
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
    var montlyPriceHistory = calculateMonthlyAverages(product.priceHistory);
    List<charts.Series<PriceHistory, DateTime>> seriesList = [
      charts.Series<PriceHistory, DateTime>(
        id: 'Price',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (PriceHistory price, _) => price.dateTime,
        measureFn: (PriceHistory price, _) => price.price,
        data: montlyPriceHistory,
      ),
    ];

    final selectionModelConfig = charts.SelectionModelConfig(
      changedListener: (charts.SelectionModel model) {
        if (model.hasDatumSelection) {
          final selectedDatum = model.selectedDatum.first;
          final value = selectedDatum.datum.price;
          final formattedDate =
              DateFormat('yyyy-MM-dd').format(selectedDatum.datum.dateTime);

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Selected Price'),
                content: Text(
                    'Value: ${value.toStringAsFixed(2)}\nDate: $formattedDate'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Close'),
                  ),
                ],
              );
            },
          );
        }
      },
    );
    
    return charts.TimeSeriesChart(
      seriesList,
      animate: true,
      dateTimeFactory: const charts.LocalDateTimeFactory(),
      defaultRenderer: charts.LineRendererConfig(
        includePoints: true,
        includeArea: true,
        radiusPx: 3.0,
        // labelAccessorFn: (charts.Series<dynamic, DateTime> series, int index) {
        //   final price = series.data[index].price;
        //   return price.toStringAsFixed(2);
        // },
      ),
    );
  }

  void showOffersDialog(BuildContext context, Product product) {
    var stores = Provider.of<ProductsProvider>(context, listen: false).stores;
    if (stores == []) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Oferte disponibile'),
            content:
                Text("Nu există oferte disponibile pentru ${product.name}"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Oferte disponibile'),
          content: Container(
            constraints: const BoxConstraints(minWidth: 500),
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(
                  product.priceHistory.length,
                  (index) {
                    final price = product.priceHistory[index];
                    final store = stores.firstWhere(
                      (store) => store.id == price.storeId,
                      orElse: () => Store(
                        address: "Unknown",
                        id: "No id",
                        location: "Unknown",
                        name: "Unknown",
                      ),
                    );

                    return OfferCard(
                      store: store,
                      price: price,
                    );
                  },
                ),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Închide'),
            ),
          ],
        );
      },
    );
  }
}
