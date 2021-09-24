import 'dart:ui';

import 'package:flutter/material.dart';

class ShadowText extends StatelessWidget {
  ShadowText({required this.text, required this.style});

  final String text;
  final TextStyle style;

  Widget build(BuildContext context) {
    return new ClipRect(
      child: new Stack(
        children: [
          new Positioned(
            top: 2.0,
            left: 2.0,
            child: new Text(
              text,
              style: style.copyWith(color: Colors.black.withOpacity(0.5)),
            ),
          ),
          new BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: new Text(text, style: style),
          ),
        ],
      ),
    );
  }
}
