import 'package:dexify/src/animations/fade_animation.dart';
import 'package:flutter/material.dart';

class EmptyDict extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      .5,
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 40),
          Image.asset(
            'assets/images/tree.png',
            height: 120,
            width: 120,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 16),
          Text(
            'Let us take a moment to reflect',
            style: TextStyle(
                fontWeight: FontWeight.w300, fontSize: 16, letterSpacing: 1.2),
          )
        ],
      ),
    );
  }
}