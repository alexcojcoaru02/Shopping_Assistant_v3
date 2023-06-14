import 'package:flutter/material.dart';

import '../utils/configuration.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Location'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on,
                color: primaryGreen,
              ),
              const Expanded(
                child: Text(
                  'Bucuresti',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
