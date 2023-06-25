import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shopping_assistant/models/product.dart';
import 'package:shopping_assistant/providers/auth_provider.dart';
import 'package:shopping_assistant/providers/products_provider.dart';
import 'package:shopping_assistant/widgets/product_sumary.dart';

class AddReviewPage extends StatelessWidget {
  final String productId;
  final Review userReview;

  const AddReviewPage({
    Key? key,
    required this.productId,
    required this.userReview,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    final size = MediaQuery.of(context).size;

    TextEditingController textController =
        TextEditingController(text: userReview.comment);
    int newRating = userReview.rating;
    String btnText = userReview.comment.isEmpty && userReview.rating == 0
        ? 'Add Review'
        : 'Edit Review';

    final product = productsProvider.products
        .firstWhere((element) => element.id == productId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Review'),
      ),
      body: Row(
        children: [
          SizedBox(
            width: size.width * .5,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: ProductSummary(productId: productId),
              ),
            ),
          ),
          SizedBox(
            width: size.width * .5,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Suarizeaza experienta ta in urma utilizarii produsului.',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w100,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  const Text(
                    'Acorda o nonta:',
                    style: TextStyle(fontSize: 12),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  RatingBar.builder(
                    initialRating: newRating.toDouble(),
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (val) {
                      newRating = val.toInt();
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Comentariu:',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText:
                          'Spune-ne daca produsul a fost pe placul tau.\n  -Se ridica la nivelul asteptarilor?\n  -A fost de calitate?\n  -Esti multumit cu raporul calitate pret?\n  -Ai recomanda si altora?',
                      hintStyle: TextStyle(fontSize: 12)
                    ),
                    controller: textController,
                    maxLines: null,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (newRating != userReview.rating ||
                          textController.text != userReview.comment) {
                        userReview.comment = textController.text;
                        productsProvider.addReview(
                          productId,
                          userReview,
                          context,
                        );

                        Navigator.pop(
                          context,
                          userReview,
                        );
                      } else {
                        Navigator.pop(context);
                        Fluttertoast.showToast(
                          msg: '',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                        );
                      }
                    },
                    child: Text(btnText),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
