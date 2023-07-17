import 'package:flutter/material.dart';
import 'package:shopping_assistant/providers/products_provider.dart';

import '../models/product.dart';
import '../models/store.dart';

class AddPriceDialog extends StatefulWidget {
  final List<Store> stores;
  final String productId;

  const AddPriceDialog(
      {super.key, required this.stores, required this.productId});

  @override
  _AddPriceDialogState createState() => _AddPriceDialogState();
}

class _AddPriceDialogState extends State<AddPriceDialog> {
  TextEditingController priceController = TextEditingController();
  String? selectedStore;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isValid = false;

  @override
  Widget build(BuildContext context) {
    selectedStore = widget.stores.first.id;
    return AlertDialog(
      title: const Text('Add Price'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            key: const ValueKey('price'),
            controller: priceController,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value != null && double.tryParse(value) == null) {
                return 'Invalid price';
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: 'Price',
            ),
            onChanged: (value) {
              setState(() {
                isValid = double.tryParse(priceController.text) != null;
              });
            },
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: selectedStore,
            items: widget.stores.map((store) {
              return DropdownMenuItem<String>(
                value: store.id,
                child: Text(store.name),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                selectedStore = value;
              });
            },
            decoration: const InputDecoration(
              labelText: 'Store',
            ),
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: isValid
              ? () {
                  final priceHistory = PriceHistory(
                    double.tryParse(priceController.text) ?? 0.0,
                    selectedStore ?? '',
                    DateTime.now(),
                  );
                  ProductsProvider()
                      .addPriceHistory(widget.productId, priceHistory);
                  Navigator.pop(
                    context,
                    PriceDialogResult(
                      double.tryParse(priceController.text) ?? 0.0,
                      selectedStore ?? '',
                    ),
                  );
                }
              : null,
          child: const Text('Add'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}

class PriceDialogResult {
  final double price;
  final String selectedStore;

  PriceDialogResult(this.price, this.selectedStore);
}

Future<PriceDialogResult?> showAddPriceDialog(
    BuildContext context, List<Store> stores, String productId) async {
  return showDialog<PriceDialogResult>(
    context: context,
    builder: (BuildContext context) {
      return AddPriceDialog(productId: productId, stores: stores);
    },
  );
}
