import 'package:flutter/material.dart';

import '../../Theme/theme.dart' as Theme;

class BlueText extends StatelessWidget {
  final double? fontSize;
  final String? text;
  BlueText({this.text, this.fontSize});
  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: (fontSize == null) ? 16 : fontSize,
        color: Theme.bluetext,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
