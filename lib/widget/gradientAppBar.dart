import 'package:cached_network_image/cached_network_image.dart';
import 'package:chitrwallpaperapp/widget/emojiText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

class AppAppbar extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subTitle;
  final String blur_hash;
  final int width;
  final int height;
  const AppAppbar({
    Key key,
    @required this.imageUrl,
    @required this.title,
    @required this.subTitle,
    @required this.blur_hash,
    @required this.width,
    @required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 364,
      title: Text(title),
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: CachedNetworkImage(
          placeholder: (context, url) => AspectRatio(
            aspectRatio: width / height,
            child: Center(
                child: BlurHash(
              hash: blur_hash != null
                  ? blur_hash
                  : "LBAdAqof00WCqZj[PDay0.WB}pof",
            )),
          ),
          imageUrl: imageUrl,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            )),
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                    Colors.black,
                    Colors.black.withOpacity(.3),
                    Colors.transparent,
                    Colors.transparent,
                    Colors.transparent,
                    Colors.transparent,
                  ])),
              child: Padding(
                // padding: EdgeInsets.all(16),
                padding: EdgeInsets.only(bottom: 8, left: 16, right: 16),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          title,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 40),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          subTitle,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            height: 150.0,
            child: Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
