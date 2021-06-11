import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

import './Screens/launch_screen.dart';
import './Screens/signin.dart';
import './Screens/singup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Yellow Class Video Player App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: LaunchScreen(),
      initialRoute: "/",
      routes: {
        "/": (ctx) => LaunchScreen(),
        "/SignIn": (ctx) => SignInScreen(),
        "/SignUp": (ctx) => SignUpScreen(),
      },
    );
  }
}
