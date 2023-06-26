import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';

class WrapperPage extends StatefulWidget {
  final Widget child;

  const WrapperPage({super.key, required this.child});

  @override
  State<WrapperPage> createState() => _WrapperPageState();
}

class _WrapperPageState extends State<WrapperPage> {
  @override
  void initState() {
    final providerProvider = Provider.of<ProductsProvider>(context, listen: false);
    providerProvider.getDataFromAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    return Stack(
      children: [
        widget.child,
        if (productProvider.isLoading)
          Container(
            color: Colors.black54,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}
