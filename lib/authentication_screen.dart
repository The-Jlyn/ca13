import 'package:flutter/material.dart';
import 'registrationwidget.dart';
import 'signin.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(showSignIn ? 'Sign In' : 'Register'),
        actions: [
          TextButton.icon(
            icon: Icon(showSignIn ? Icons.person_add : Icons.person),
            label: Text(showSignIn ? 'Register' : 'Sign In'),
            onPressed: toggleView,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: showSignIn ? const SignInWidget() : const RegisterWidget(),
      ),
    );
  }
}
