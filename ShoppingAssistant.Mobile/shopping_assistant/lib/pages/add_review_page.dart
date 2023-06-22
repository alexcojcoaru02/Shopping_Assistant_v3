import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:shopping_assistant/models/product.dart';
import 'package:shopping_assistant/providers/auth_provider.dart';
import 'package:shopping_assistant/providers/products_provider.dart';

class AddReviewPage extends StatelessWidget {
  final String productId;

  const AddReviewPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);

    final authprovider = Provider.of<AuthProvider>(context);

    String comment = '';
    double rating = 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Review'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Rating:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                rating = rating;
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Comment:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your comment',
              ),
              onChanged: (value) {
                comment = value;
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                productsProvider.addReview(
                  productId,
                  Review(
                    rating.toInt(),
                    comment,
                    "string",
                    authprovider.username,
                    DateTime.now(),
                  ),
                  context,
                );

                Navigator.pop(context);
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
