import 'package:flutter/material.dart';

import '../utils/configuration.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Location'),
        Row(
          children: [
            Icon(
              Icons.location_on,
              color: primaryGreen,
            ),
            const Text('Bucuresti'),
          ],
        ),
      ],
    );
  }
}
