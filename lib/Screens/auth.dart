import 'package:flutter/material.dart';

import "./signin.dart";
import "./singup.dart";

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool showSignInScreen = true;
  void toggle() {
    setState(() {
      showSignInScreen = !showSignInScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showSignInScreen
        ? SignInScreen(callback: toggle)
        : SignUpScreen(callback: toggle);
  }
}
