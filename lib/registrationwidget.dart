import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'authservice.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({super.key});

  @override
  _RegisterWidgetState createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () async {
                // Input validation
                if (_emailController.text.isEmpty || !_emailController.text.contains('@')) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a valid email.'))
                  );
                  return;
                }

                if (_passwordController.text.length < 6) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Password must be at least 6 characters.'))
                  );
                  return;
                }

                try {
                  // Register the user
                  User? user = await _authService.registerWithEmailAndPassword(
                    _emailController.text,
                    _passwordController.text,
                  );
                  if (user != null) {
                    Navigator.pushReplacementNamed(context, '/home');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Registration failed.'))
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $e'))
                  );
                }
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
