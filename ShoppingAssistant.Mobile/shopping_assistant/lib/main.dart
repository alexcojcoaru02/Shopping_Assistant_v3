import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_assistant/pages/exemplu_listare_produse.dart';
import 'package:shopping_assistant/pages/welcome_page.dart';
import 'package:shopping_assistant/providers/products_provider.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductsProvider(),
      child: MaterialApp(
        title: 'Shopping Assistant',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const ExempluListare(),
      ),
    );
  }
}
