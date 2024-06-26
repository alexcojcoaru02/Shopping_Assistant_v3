import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/product.dart';

Color primaryGreen = const Color(0xff416d6d);
LinearGradient gradient = const LinearGradient(colors: [
  Color(0xff382743),
  Color(0xffff4590),
], stops: [
  0.0,
  1.0
], begin: FractionalOffset.topLeft, end: FractionalOffset.bottomRight);
List<BoxShadow> shadowList = [
  const BoxShadow(
      color: Color.fromRGBO(183, 181, 181, 1),
      blurRadius: 30,
      offset: Offset(0, 10))
];

const String googleApiKey = 'AIzaSyCidZhqIwj8xB9zxErdA90Kxdt_gjpuOEI';

List<Map> categories = [
  {
    'name': 'Electronics',
    'iconPath': 'assets/images/categories/electronics.png'
  },
  {'name': 'Fashion', 'iconPath': 'assets/images/categories/fashion.png'},
  {'name': 'Beauty', 'iconPath': 'assets/images/categories/beauty.png'},
  {'name': 'Groceries', 'iconPath': 'assets/images/categories/food.png'},
  {'name': 'Home', 'iconPath': 'assets/images/categories/food.png'},
  {'name': 'Sports', 'iconPath': 'assets/images/categories/sports.png'}
];

List<Map> drawerItems = [
  {'icon': FontAwesomeIcons.paw, 'title': 'Adoption'},
  {'icon': Icons.mail, 'title': 'Donation'},
  {'icon': FontAwesomeIcons.plus, 'title': 'Add pet'},
  {'icon': Icons.favorite, 'title': 'Favorites'},
  {'icon': Icons.mail, 'title': 'Messages'},
  {'icon': FontAwesomeIcons.userAlt, 'title': 'Profile'},
];

bool isMobile() {
  if (Platform.isAndroid || Platform.isIOS) {
    return true;
  }
  return false;
}

List<int> getReviewCounts(List<Review> reviews) {
  List<int> reviewCounts = [0, 0, 0, 0, 0];

  for (var review in reviews) {
    if (review.rating >= 1 && review.rating <= 5) {
      reviewCounts[review.rating - 1]++;
    }
  }

  return reviewCounts;
}

double calculateAverageRating(List<Review> reviews) {
  if (reviews.isEmpty) {
    return 0.0;
  }

  double sum = 0.0;
  for (Review review in reviews) {
    sum += review.rating;
  }

  return sum / reviews.length;
}

double calculateAveragePrice(List<Product> products) {
  if (products.isEmpty) {
    return 0.0;
  }
  double total = 0;
  for (var product in products) {
    for (var price in product.priceHistory) {
      total += price.price;
    }
  }

  return total / products.length;
}

double calculateMinimumPrice(product) {
  if (product.priceHistory.isNotEmpty) {
    double minimumPrice = double.infinity;
    for (var price in product.priceHistory) {
      if (price.price < minimumPrice) {
        minimumPrice = price.price;
      }
    }
    return minimumPrice;
  }
  return 0;
}

List<PriceHistory> calculateMonthlyAverages(
    List<PriceHistory> priceHistoryList) {
  Map<String, List<PriceHistory>> monthlyData = {};

  for (PriceHistory priceHistory in priceHistoryList) {
    String monthYearKey =
        '${priceHistory.dateTime.year}-0${priceHistory.dateTime.month}-01';

    if (monthlyData.containsKey(monthYearKey)) {
      monthlyData[monthYearKey]!.add(priceHistory);
    } else {
      monthlyData[monthYearKey] = [priceHistory];
    }
  }

  String? findMostFrequentStoreId(List<Product> products) {
    Map<String, int> countMap = {};
    int maxCount = 0;
    String? mostFrequentStoreId;

    for (var product in products) {
      for (var priceHistory in product.priceHistory) {
        String storeId = priceHistory.storeId;
        countMap[storeId] = (countMap[storeId] ?? 0) + 1;
        if (countMap[storeId]! > maxCount) {
          maxCount = countMap[storeId]!;
          mostFrequentStoreId = storeId;
        }
      }
    }

    return mostFrequentStoreId;
  }

  List<PriceHistory> monthlyAverages = [];
  monthlyData.forEach((monthYearKey, priceHistoryList) {
    double sum = 0.0;
    for (PriceHistory priceHistory in priceHistoryList) {
      sum += priceHistory.price;
    }
    double average = sum / priceHistoryList.length;

    DateTime monthYear = DateTime.parse(monthYearKey);

    PriceHistory monthlyAveragePrice = PriceHistory(
      average,
      priceHistoryList[0].storeId,
      monthYear,
    );

    monthlyAverages.add(monthlyAveragePrice);
  });

  return monthlyAverages;
}

void _launchURL(String address) async {
  final url = Uri.parse(address);
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
