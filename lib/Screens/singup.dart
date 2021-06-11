import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Utilities/Widgets/mycontainer.dart';
import '../Utilities/Widgets/largebutton.dart';
import '../Utilities/Widgets/mytitle.dart';
import '../Utilities/Widgets/mainlogo.dart';
import '../Utilities/Widgets/bluetext.dart';
import '../Theme/theme.dart' as Theme;

class SignUpScreen extends StatefulWidget {
  final Function()? callback;
  const SignUpScreen({Key? key, this.callback}) : super(key: key);
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();
  bool showPassword = false;
  bool showConfirmPassword = false;

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
    //

    //
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraint) {
          return SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 50),
                    MainLogo(),
                    SizedBox(height: 10),
                    MyTitle(text: "Create Your Account"),
                    BlueText(text: "Sign up using your email"),
                    SizedBox(height: 30),
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
                                                ? 'assets/images/OpenEye.png'
                                                : 'assets/images/HideEye.png'),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
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
                                      controller: _confirmPassController,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.text,
                                      obscureText: !showConfirmPassword,
                                      decoration: new InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        hintText: "Confirm Password",
                                        hintStyle: Theme.textfield_textstyle,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          showConfirmPassword =
                                              !showConfirmPassword;
                                        });
                                      },
                                      child: Container(
                                        height: 20,
                                        width: 20,
                                        child: Center(
                                          child: Image(
                                            image: AssetImage(
                                                (showConfirmPassword)
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
                            //
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 30, 0, 30),
                              child: LargeButton(
                                text: "Sign Up",
                                callback: () async {
//
                                  if (_emailController.text == null ||
                                      _emailController.text.length == 0) {
                                    showSnakBar(
                                        message:
                                            "Please Provide Email Address");
                                  } else if (_passController.text == null ||
                                      _passController.text.length == 0) {
                                    showSnakBar(
                                        message: "Please Provide Password");
                                  } else if (_confirmPassController.text ==
                                          null ||
                                      _confirmPassController.text.length == 0) {
                                    showSnakBar(
                                        message:
                                            "Please Provide Confirm Password");
                                  } else if (_confirmPassController.text
                                          .toString() !=
                                      _passController.text.toString()) {
                                    showSnakBar(
                                        message:
                                            "Password And Confirm Password Doesn't Match");
                                  } else {
                                    try {
                                      await FirebaseAuth.instance
                                          .createUserWithEmailAndPassword(
                                              email:
                                                  _emailController.text.trim(),
                                              password:
                                                  _passController.text.trim());
                                    } on FirebaseAuthException catch (e) {
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
                                  "Already have an account? ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                InkWell(
                                  onTap: widget.callback,
                                  child: Text(
                                    "Sign in",
                                    style: TextStyle(
                                      fontSize: 18,
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
