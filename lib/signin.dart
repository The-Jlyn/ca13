import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'AuthService.dart';

class SignInWidget extends StatefulWidget {
  const SignInWidget({super.key});

  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Column(
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
            User? user = await _authService.signInWithEmailAndPassword(
              _emailController.text,
              _passwordController.text,
            );
            if (user != null) {
              Navigator.pushReplacementNamed(context, '/home');
            }
          },
          child: const Text('Sign In'),
        ),
      ],
    );
  }
}
