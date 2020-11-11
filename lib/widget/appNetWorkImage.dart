import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

class AppNetWorkImage extends StatelessWidget {
  final String imageUrl;
  final String blur_hash;
  final String userName;

  const AppNetWorkImage(
      {Key key,
      @required this.imageUrl,
      @required this.blur_hash,
      @required this.userName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: imageUrl,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) => BlurHash(
            hash:
                blur_hash != null ? blur_hash : "LBAdAqof00WCqZj[PDay0.WB}pof",
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ],
    );
  }
}
