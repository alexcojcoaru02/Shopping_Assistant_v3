import 'package:flutter/material.dart';

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
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Location',
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on,
                color: primaryGreen,
              ),
              const SizedBox(width: 5),
              const Text(
                'Bucuresti',
                style: TextStyle(
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          color: primaryGreen,
          onPressed: () {
            // TODO: Handle shopping cart button press
          },
        ),
      ],
    );
  }
}
