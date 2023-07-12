import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../models/product.dart';
import '../utils/configuration.dart';

class ReviewSumary extends StatelessWidget {
  final List<Review> reviews;
  const ReviewSumary({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          buildReviewSumary(
            calculateAverageRating(reviews),
            reviews.length,
          ),
          const SizedBox(width: 16),
          buildNumberReviewIndicator(
            getReviewCounts(reviews),
          ),
        ],
      ),
    );
  }
}

Widget buildReviewSumary(double averageRating, int reviewCount) {
  return Column(
    children: [
      Text(
        averageRating.toStringAsFixed(2),
        style: const TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
      const SizedBox(height: 8),
      RatingBarIndicator(
        rating: averageRating,
        itemCount: 5,
        itemSize: 20.0,
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: Colors.amber,
        ),
      ),
      const SizedBox(height: 8),
      Text(
        '$reviewCount review-uri',
        style: const TextStyle(fontSize: 16),
      ),
    ],
  );
}

Widget buildNumberReviewIndicator(List<int> starAggregates) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Rating Distribution',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10),
      for (int i = 0; i < starAggregates.length; i++)
        buildProgressBar(starAggregates, i + 1, starAggregates[i]),
    ],
  );
}

Widget buildProgressBar(List<int> starAggregates, int rating, int count) {
  return SizedBox(
    width: 194,
    child: Row(
      children: [
        Text(
          '$rating stele',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: LinearProgressIndicator(
            value: count / starAggregates.reduce((a, b) => a + b),
            color: Colors.amber,
            backgroundColor: Colors.grey[300],
          ),
        ),
        const SizedBox(width: 10),
        Text('($count)'),
      ],
    ),
  );
}
