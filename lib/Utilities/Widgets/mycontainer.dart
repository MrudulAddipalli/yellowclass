import 'package:flutter/material.dart';

import '../../Theme/theme.dart' as Theme;

class MyContainer extends StatelessWidget {
  final Widget? child;
  final double? height;
  final bool? requireMargin;
  final double? radius;
  MyContainer({
    @required this.child,
    this.height,
    this.requireMargin,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 60,
      margin:
          (requireMargin == null) ? EdgeInsets.fromLTRB(0, 10, 0, 10) : null,
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular((radius == null) ? 15 : radius!),
        border: Border.all(width: 2, color: Theme.grey_border),
        color: Theme.grey_bg_1,
      ),
      child: Center(child: child),
    );
  }
}
