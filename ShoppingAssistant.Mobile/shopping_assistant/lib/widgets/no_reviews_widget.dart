import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';
import '../pages/add_review_page.dart';

buildNoReviewsWidget(String productId, BuildContext context) {
  var userReview = Review(
    0,
    '',
    'string',
    '',
    DateTime.now(),
  );

  return SizedBox(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'No reviews yet',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Detii sau ai utilizat produsul?',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Spune-ti parerea acordand o nota produsului',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddReviewPage(
                        productId: productId,
                        userReview: userReview,
                      ),
                    ),
                  );
                },
                child: const Text('Add Review'),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
