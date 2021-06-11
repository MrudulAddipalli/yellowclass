import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './auth.dart';
import './video_screen.dart';

class LaunchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            print("waiting");
            return Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasError) {
              if (snapshot.data == null) {
                return AuthScreen();
              } else {
                return VideoScreen();
              }
            } else if (snapshot.hasError) {
              print(
                  "Something Went Wrong, Please Check Your Internet Connection");
              return Center(
                  child: Text(
                      "Something Went Wrong, Please Check Your Internet Connection"));
            } else {
              print("waiting2");
              return Center(child: CircularProgressIndicator());
            }
          }
        },
      ),

      // VideoScreen(),
    );
  }
}
