import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_assistant/pages/exemplu_listare_produse.dart';
import 'package:shopping_assistant/pages/login_page.dart';
import 'package:shopping_assistant/pages/wrapper_page.dart';
import 'package:shopping_assistant/providers/auth_provider.dart';
import 'package:shopping_assistant/providers/products_provider.dart';
import 'package:shopping_assistant/widgets/custom_appbar.dart';
import 'package:shopping_assistant/widgets/drawer.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key});

  @override
  Widget build(BuildContext context) {
    final authProvider = AuthProvider();
    final productsProvider = ProductsProvider();
    authProvider.checkAuthStatus();

    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AuthProvider()),
        ChangeNotifierProvider.value(value: ProductsProvider()),
      ],
      child: Container(
        color: Colors.grey[200],
        width: double.infinity,
        child: MaterialApp(
          title: 'Shopping Assistant',
          debugShowCheckedModeBanner: false,
          home: Consumer<AuthProvider>(
            builder: (context, authProvider, _) {
              if (authProvider.isAuthenticated) {
                return Scaffold(
                  key: scaffoldKey,
                  appBar: CustomAppBar(),
                  drawer: CustomDrawer(),
                  body: const WrapperPage(child: ExempluListare()),
                );
              } else {
                return const LoginPage();
              }
            },
          ),
        ),
      ),
    );
  }
}
