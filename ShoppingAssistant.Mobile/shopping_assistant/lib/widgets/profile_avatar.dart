import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String name;
  final double size;

  const ProfileAvatar({required this.name, this.size = 48});

  @override
  Widget build(BuildContext context) {
    final words = name.split(' ');
    final initials = words.length >= 2
        ? '${words[0][0]}${words[1][0]}'.toUpperCase()
        : name.isNotEmpty
            ? name.substring(0, 2).toUpperCase()
            : '';

    return Center(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[300],
        ),
        child: Center(
          child: Text(
            initials,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: size * 0.4,
            ),
          ),
        ),
      ),
    );
  }
}
