import 'package:flutter/material.dart';

import '../utils/configuration.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Location'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  color: primaryGreen,
                  onPressed: () {
                    scaffoldKey.currentState?.openDrawer();
                  },
                ),
              ),
              Icon(
                Icons.location_on,
                color: primaryGreen,
              ),
              const SizedBox(width: 5),
              const Expanded(
                child: Text(
                  'Bucuresti',
                  textAlign: TextAlign.center,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                color: primaryGreen,
                onPressed: () {
                  // todo
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
