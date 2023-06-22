import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shopping_assistant/models/product.dart';
import 'package:intl/intl.dart';

import '../pages/add_review_page.dart';

class RatingSection extends StatelessWidget {
  final Product product;
  final List<Review> reviews;
  const RatingSection(
      {super.key, required this.reviews, required this.product});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          width: size.width * 0.9,
          child: const Divider(
            color: Colors.grey,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Reviews (${reviews.length})',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddReviewPage(productId: product.id),
                  ),
                );
              },
              child: const Text('Adăugare Review'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            buildReviewSection(
              calculateAverageRating(reviews),
              reviews.length,
            ),
            const SizedBox(width: 16),
            RatingDistribution(
              reviewCounts: getReviewCounts(reviews),
            ),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: reviews.length,
          itemBuilder: (context, index) {
            final review = reviews[index];
            return Column(
              children: [
                SizedBox(
                  width: size.width * 0.9,
                  child: const Divider(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),
                buildReviewRow(review, context),
                const SizedBox(height: 16),
              ],
            );
          },
        ),
      ],
    );
  }
}

Widget buildReviewRow(Review review, BuildContext context) {
  var size = MediaQuery.of(context).size;
  return SizedBox(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: size.width < 500 ? size.width * 0.3 : 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                review.userName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                DateFormat('dd MMMM yyyy').format(review.dateTime).toString(),
                style: const TextStyle(
                  color: Colors.grey,
                ),
                maxLines: 3,
                softWrap: true,
              ),
            ],
          ),
        ),
        SizedBox(
          width: size.width * 0.6,
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RatingBarIndicator(
                    rating: review.rating.toDouble(),
                    itemCount: 5,
                    itemSize: 20.0,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: size.width * 0.6,
                    child: Text(
                      review.comment,
                      style: const TextStyle(
                        fontSize: 14,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildReviewSection(double averageRating, int reviewCount) {
  return Column(
    children: [
      Text(
        averageRating.toStringAsFixed(2),
        style: const TextStyle(
            fontSize: 44, fontWeight: FontWeight.bold, color: Colors.grey),
      ),
      const SizedBox(height: 8),
      RatingBarIndicator(
        rating: averageRating,
        itemCount: 5,
        itemSize: 25.0,
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

class RatingDistribution extends StatelessWidget {
  final List<int> reviewCounts;

  const RatingDistribution({required this.reviewCounts});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Rating Distribution',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        for (int i = 0; i < reviewCounts.length; i++)
          buildProgressBar(i + 1, reviewCounts[i]),
      ],
    );
  }

  Widget buildProgressBar(int rating, int count) {
    return SizedBox(
      width: 210,
      child: Row(
        children: [
          Text(
            '$rating stele',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: LinearProgressIndicator(
              value: count / reviewCounts.reduce((a, b) => a + b),
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
