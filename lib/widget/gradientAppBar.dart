import 'package:cached_network_image/cached_network_image.dart';
import 'package:chitrwallpaperapp/responsive/enums/device_screen_type.dart';
import 'package:chitrwallpaperapp/responsive/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

class AppAppbar extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subTitle;
  final String blurHash;
  final int width;
  final int height;
  const AppAppbar({
    Key key,
    @required this.imageUrl,
    @required this.title,
    @required this.subTitle,
    @required this.blurHash,
    @required this.width,
    @required this.height,
  }) : super(key: key);

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    DeviceScreenType deviceScreenType = getDeviceType(mediaQuery);
    return SliverAppBar(
      expandedHeight: 364,
      pinned: deviceScreenType == DeviceScreenType.Tablet ? true : false,
      title: Text(title),
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: CachedNetworkImage(
          placeholder: (context, url) => AspectRatio(
            aspectRatio: width / height,
            child: Center(
                child: BlurHash(
              hash:
                  blurHash != null ? blurHash : "LBAdAqof00WCqZj[PDay0.WB}pof",
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
                          removeAllHtmlTags(subTitle),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: ''),
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
