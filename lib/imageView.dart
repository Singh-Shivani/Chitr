import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  final List items;
  final int index;

  ImageView({@required this.items, @required this.index});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: items[index],
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.network(
            items[index][1],
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
