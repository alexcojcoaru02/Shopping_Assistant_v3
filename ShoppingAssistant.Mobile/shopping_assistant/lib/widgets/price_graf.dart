import 'dart:math';

import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../models/product.dart';

Widget buildPriceHistoryGraph(Product product) {
  List<Series<PriceHistory, DateTime>> seriesList = [
    Series<PriceHistory, DateTime>(
      id: 'Price',
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      domainFn: (PriceHistory price, _) => price.dateTime,
      measureFn: (PriceHistory price, _) => price.price,
      data: product.priceHistory,
      labelAccessorFn: (PriceHistory price, _) =>
          '${price.price.toStringAsFixed(2)} Lei', // Afișează valoarea în nod
    ),
  ];

  return TimeSeriesChart(
    seriesList,
    animate: true,
    dateTimeFactory: const LocalDateTimeFactory(),
    defaultRenderer: LineRendererConfig(
      includePoints: true, // Include puncte pentru fiecare nod
      includeArea: true, // Includere zonă sub linie
      stacked: false,
      radiusPx: 3, // Dimensiunea punctelor
      strokeWidthPx: 2, // Grosimea liniei
    ),
    behaviors: [
      charts.LinePointHighlighter(
        symbolRenderer: CustomSymbolRenderer(), // Utilizarea unui symbol renderer personalizat
      ),
      charts.PanAndZoomBehavior(), // Adăugarea comportamentului de panoramare și zoom
    ],
  );
}

class CustomSymbolRenderer extends charts.CircleSymbolRenderer {
  @override
  void paint(ChartCanvas canvas, Rectangle<num> bounds,
      {List<int>? dashPattern,
      Color? fillColor,
      FillPatternType? fillPattern,
      Color? strokeColor,
      double? strokeWidthPx}) {
    super.paint(canvas, bounds,
        dashPattern: dashPattern,
        fillColor: fillColor,
        fillPattern: fillPattern,
        strokeColor: strokeColor,
        strokeWidthPx: strokeWidthPx);

  }
}
