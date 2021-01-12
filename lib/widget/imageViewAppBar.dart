import 'package:flutter/material.dart';

class ImageViewAppBar extends StatelessWidget {
  final Function function;

  const ImageViewAppBar({Key key, @required this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListTile(
        leading: IconButton(
            icon: Icon(Icons.close, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            }),
        trailing: IconButton(
            icon: Icon(Icons.favorite, color: Colors.red),
            onPressed: () {
              function();
            }),
      ),
    );
  }
}
