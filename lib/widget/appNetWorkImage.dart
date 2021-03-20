import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

class AppNetWorkImage extends StatelessWidget {
  final String imageUrl;
  final String blurHash;
  final int width;
  final int height;

  const AppNetWorkImage({
    Key key,
    @required this.imageUrl,
    @required this.blurHash,
    @required this.width,
    @required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => AspectRatio(
        aspectRatio: width / height,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      placeholder: (context, url) => AspectRatio(
        aspectRatio: width / height,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          child: BlurHash(
            image: imageUrl,
            hash: blurHash != null ? blurHash : "LBAdAqof00WCqZj[PDay0.WB}pof",
          ),
        ),
      ),
      errorWidget: (context, url, error) => AspectRatio(
          aspectRatio: width / height, child: Center(child: Icon(Icons.error))),
    );
  }
}
