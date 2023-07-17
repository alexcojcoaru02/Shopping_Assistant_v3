import 'package:flutter/material.dart';
import 'package:shopping_assistant/providers/auth_provider.dart';
import 'package:shopping_assistant/widgets/profile_avatar.dart';

import '../utils/configuration.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = AuthProvider();

    return Scaffold(
      appBar: AppBar(        
        backgroundColor: primaryGreen,
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfileAvatar(name: authProvider.username),
            const SizedBox(height: 16),
            Text(
              authProvider.username,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Email: example@gmail.com',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
