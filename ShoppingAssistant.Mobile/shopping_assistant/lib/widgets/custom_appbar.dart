import 'package:flutter/material.dart';
import 'package:shopping_assistant/widgets/location_widget.dart';

import '../pages/shopping_cart_page.dart';
import '../utils/configuration.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: primaryGreen),
      leadingWidth: 60,
      backgroundColor: const Color(0xfff0f1f5),
      elevation: 0,
      title: const LocationWidget(),
      centerTitle: true,  
      actions: [
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          color: primaryGreen,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ShoppingCartPage(),
              ),
            );
          },
        ),
      ],
    );
  }
}
