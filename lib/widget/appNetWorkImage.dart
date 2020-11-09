import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';

class AppNetWorkImage extends StatelessWidget {
  final String imageUrl;
  const AppNetWorkImage({Key key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => Center(
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
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
