import 'package:flutter/material.dart';

class ResponsiveLayoutWidget extends StatelessWidget {
  final Widget child1;
  final Widget child2;

  const ResponsiveLayoutWidget({
    Key? key,
    required this.child1,
    required this.child2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth > 600) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          child1,
          child2,
        ],
      );
    } else {
      return Column(
        children: [child1, child2],
      );
    }
  }
}
