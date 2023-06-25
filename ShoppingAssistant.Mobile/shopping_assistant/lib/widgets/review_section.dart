import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shopping_assistant/models/product.dart';
import 'package:intl/intl.dart';
import 'package:shopping_assistant/providers/auth_provider.dart';
import 'package:shopping_assistant/widgets/review_sumary_widget.dart';

import '../pages/add_review_page.dart';
import '../providers/products_provider.dart';

class RatingSection extends StatefulWidget {
  final Product product;
  final String productId;

  const RatingSection({
    super.key,
    required this.product,
    required this.productId,
  });

  @override
  State<RatingSection> createState() => _RatingSectionState();
}

class _RatingSectionState extends State<RatingSection> {
  late List<Review> reviews;
  late String userName;
  late bool hasUserReviewed;

  @override
  void initState() {
    ProductsProvider().getDataFromAPI();
    reviews = ProductsProvider()
        .products
        .firstWhere((element) => element.id == widget.productId)
        .reviews;
    userName = AuthProvider().username;
    hasUserReviewed = reviews.any((review) => review.userName == userName);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String addEditButton = hasUserReviewed ? 'Edit Review' : 'Add Review';
    reviews = ProductsProvider()
        .products
        .where((element) => element.id == widget.productId)
        .first
        .reviews;
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
                    builder: (context) =>
                        AddReviewPage(productId: widget.product.id),
                  ),
                ).then(
                  (value) => {
                    Future.delayed(const Duration(milliseconds: 1000), () {
                      setState(() {
                        reviews.add(value);
                        hasUserReviewed = true;
                      });
                    })
                  },
                );
              },
              child: Text(addEditButton),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ReviewSumary(reviews: reviews,),
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
                buildReviewitem(review, context),
                const SizedBox(height: 16),
              ],
            );
          },
        ),
      ],
    );
  }
}

Widget buildReviewitem(Review review, BuildContext context) {
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
