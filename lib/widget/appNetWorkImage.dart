import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';

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
    return AspectRatio(
      aspectRatio: width / height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: OctoImage(
          image: CachedNetworkImageProvider(imageUrl),
          placeholderBuilder: OctoPlaceholder.blurHash(
            blurHash != null ? blurHash : "LBAdAqof00WCqZj[PDay0.WB}pof",
          ),
          errorBuilder: OctoError.icon(color: Colors.red),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
