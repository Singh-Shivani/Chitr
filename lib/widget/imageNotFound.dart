import 'package:flutter/material.dart';

class ImageNotFound extends StatelessWidget {
  const ImageNotFound({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "No Image Found",
      style: TextStyle(color: Theme.of(context).accentColor, fontSize: 19),
    );
  }
}
