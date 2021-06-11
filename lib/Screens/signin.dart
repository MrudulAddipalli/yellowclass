import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Utilities/Widgets/mycontainer.dart';
import '../Utilities/Widgets/largebutton.dart';
import '../Utilities/Widgets/mytitle.dart';
import '../Utilities/Widgets/mainlogo.dart';
import '../Utilities/Widgets/bluetext.dart';
import '../Theme/theme.dart' as Theme;

class SignInScreen extends StatefulWidget {
  final Function()? callback;

  const SignInScreen({Key? key, this.callback}) : super(key: key);
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool showPassword = false;

  //

  void showSnakBar({String message = "Error"}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
    ));
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraint) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 80),
                    MainLogo(),
                    SizedBox(height: 10),
                    MyTitle(text: "Welcome!"),
                    BlueText(text: "Sign in to access your account"),
                    SizedBox(height: 50),
                    Container(
                      width: (constraint.maxWidth < 450)
                          ? constraint.maxWidth * 0.9
                          : 400,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            MyContainer(
                              child: TextFormField(
                                // maxLength: 10,
                                style: Theme.textfield_textstyle,
                                controller: _emailController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.emailAddress,
                                decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  hintText: "Email",
                                  hintStyle: Theme.textfield_textstyle,
                                ),
                              ),
                            ),
                            MyContainer(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 9,
                                    child: TextFormField(
                                      // maxLength: 10,
                                      style: Theme.textfield_textstyle,
                                      controller: _passController,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.text,
                                      obscureText: !showPassword,
                                      decoration: new InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        hintText: "Password",
                                        hintStyle: Theme.textfield_textstyle,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          showPassword = !showPassword;
                                        });
                                      },
                                      child: Container(
                                        height: 20,
                                        width: 20,
                                        child: Center(
                                          child: Image(
                                            image: AssetImage((showPassword)
                                                ? 'assets/open_eye.png'
                                                : 'assets/hide_eye.png'),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 30, 0, 30),
                              child: LargeButton(
                                text: "Sign In",
                                callback: () async {
                                  if (_emailController.text == null ||
                                      _emailController.text.length == 0) {
                                    showSnakBar(
                                        message:
                                            "Please Provide Email Address");
                                  } else if (_passController.text == null ||
                                      _passController.text.length == 0) {
                                    showSnakBar(
                                        message: "Please Provide Password");
                                  } else {
                                    try {
                                      await FirebaseAuth.instance
                                          .signInWithEmailAndPassword(
                                              email:
                                                  _emailController.text.trim(),
                                              password:
                                                  _passController.text.trim());
                                    } on FirebaseAuthException catch (e) {
                                      print("dfafadf");
                                      showSnakBar(message: e.message!);
                                    } catch (e) {
                                      showSnakBar(message: e.toString());
                                    }
                                  }
                                },
                                type: "blue",
                              ),
                            ),
                            Wrap(
                              children: [
                                Text(
                                  "Not Registered Yet? ",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                InkWell(
                                  onTap: widget.callback,
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.bluetext,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 50),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
