import 'package:flutter/material.dart';

import '../../Theme/theme.dart' as Theme;

class MyTitle extends StatelessWidget {
  final String? text;
  final double? fontSize;
  MyTitle({this.text, this.fontSize});
  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: (fontSize == null) ? 25 : fontSize,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }
}
