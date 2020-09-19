import 'package:flutter/material.dart';

class ActivityIcon extends StatelessWidget {
  String image;
  String name;
  Color colour;

  ActivityIcon(this.image, this.name, this.colour);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80,
        child: Column(
          children: <Widget>[
            Image.asset(
              image,
              height: 55,
              width: 55,
            ),
            Text(name)
          ],
        ),
        decoration: BoxDecoration(
          border: Border.all(color: colour),
        ));
  }
}
