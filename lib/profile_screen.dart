import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'authservice.dart';

class ProfileScreen extends StatelessWidget {
  final AuthService _authService = AuthService();

  ProfileScreen({super.key});

  

  @override
  Widget build(BuildContext context) {
    User? user = _authService.auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _authService.signOut();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Welcome, ${user?.email}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _authService.resetPassword(user!.email!);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Password reset email sent')),
                );
              },
              child: const Text('Change Password'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _authService.signOut();
                Navigator.pushReplacementNamed(context, '/');
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}

