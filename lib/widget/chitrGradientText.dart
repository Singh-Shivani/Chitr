import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';

class ChitrGradientText extends StatelessWidget {
  const ChitrGradientText({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GradientText("Chitr",
          gradient: LinearGradient(colors: [
            Color.fromRGBO(254, 225, 64, 1),
            Color.fromRGBO(245, 87, 108, 1),
          ]),
          style: TextStyle(
            fontSize: 47,
            fontFamily: 'DancingScript',
            letterSpacing: 1,
          ),
          textAlign: TextAlign.center),
    );
  }
}
