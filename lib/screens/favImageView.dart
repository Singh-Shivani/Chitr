import 'package:cached_network_image/cached_network_image.dart';
import 'package:chitrwallpaperapp/database/dataBaseHelper/database_helper.dart';
import 'package:chitrwallpaperapp/database/data_modal/favImage.dart';
import 'package:chitrwallpaperapp/modal/downloadOption.dart';
import 'package:chitrwallpaperapp/provider/favImageProvider.dart';
import 'package:chitrwallpaperapp/widget/cartModaleView.dart';
import 'package:chitrwallpaperapp/widget/imageViewAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:http/http.dart' as http;
import 'package:image_downloader/image_downloader.dart';
import 'package:provider/provider.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

class FavImageView extends StatefulWidget {
  final FavImage favImage;

  FavImageView({this.favImage});

  @override
  _FavImageViewState createState() => _FavImageViewState();
}

class _FavImageViewState extends State<FavImageView> {
  bool existence;
  Modal modal = new Modal();
  List<DownloadOption> downloadOptionList = [];
  final dbHelper = FavImageDatabaseHelper.instance;

  downloadImage(String imageUrl) async {
    try {
      // Saved with this method.
      var imageId = await ImageDownloader.downloadImage(
        imageUrl,
        destination: AndroidDestinationType.directoryPictures,
      );
      if (imageId == null) {}
      // Below is a method of obtaining saved image information.
      var fileName = await ImageDownloader.findName(imageId);
      var path = await ImageDownloader.findPath(imageId);
      var size = await ImageDownloader.findByteSize(imageId);
      var mimeType = await ImageDownloader.findMimeType(imageId);

      showOverlayNotification((context) {
        return CustomNotificationOnPage(
          icon: Icons.done,
          iconColor: Colors.green,
          subTitle: 'Downloaded',
        );
      }, duration: Duration(milliseconds: 3000));
    } on PlatformException catch (error) {
      showOverlayNotification((context) {
        return CustomNotificationOnPage(
          icon: Icons.error_outline,
          iconColor: Colors.red,
          subTitle: "Sorry, couldn't download",
        );
      }, duration: Duration(milliseconds: 3000));
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    createUrlList();
  }

  createUrlList() async {
    List urls = [
      {
        "type": "Small",
        "url": widget.favImage.small,
      },
      {
        "type": "Regular",
        "url": widget.favImage.regular,
      },
      {
        "type": "Full",
        "url": widget.favImage.full,
      },
      {"type": "Raw", "url": widget.favImage.raw}
    ];

    for (var i = 0; i < urls.length; i++) {
      http.Response r = await http.head(urls[i]['url']);
      DownloadOption downloadOption = new DownloadOption(
          urls[i]['url'], urls[i]['type'], r.headers["content-length"]);
      setState(() {
        downloadOptionList.add(downloadOption);
      });
    }
  }

  void _onVerticalSwipe(SwipeDirection direction) {
    if (direction == SwipeDirection.up) {
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
    }
  }

  void _onHorizontalSwipe(SwipeDirection direction) {
    if (direction == SwipeDirection.left) {
      ;
    } else {}
  }

  Future<void> likeUnlikeImage(favImageProvider) async {
    final dbHelper = FavImageDatabaseHelper.instance;
    final hasData = await dbHelper.hasData(widget.favImage.imageid.toString());
    if (hasData) {
      favImageProvider.removeFavImage(widget.favImage.imageid);
      showOverlayNotification((context) {
        return CustomNotificationOnPage(
          icon: Icons.favorite,
          iconColor: Colors.black,
          subTitle: 'Image Removed form your Favourites.',
        );
      }, duration: Duration(milliseconds: 3000));
    } else {
      showOverlayNotification((context) {
        return CustomNotificationOnPage(
          icon: Icons.favorite,
          iconColor: Colors.black,
          subTitle: 'Image already Removed form Favourites.',
        );
      }, duration: Duration(milliseconds: 3000));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SimpleGestureDetector(
        onVerticalSwipe: _onVerticalSwipe,
        onHorizontalSwipe: _onHorizontalSwipe,
        swipeConfig: SimpleSwipeConfig(
          verticalThreshold: 40.0,
          horizontalThreshold: 40.0,
          swipeDetectionBehavior: SwipeDetectionBehavior.continuousDistinct,
        ),
        child: Stack(
          children: [
            Hero(
              tag: widget.favImage.imageid,
              child: InteractiveViewer(
                child: CachedNetworkImage(
                  imageUrl: widget.favImage.thumb,
                  imageBuilder: (context, imageProvider) => Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.contain,
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
                ),
              ),
            ),
            Consumer<FavImageProvider>(
                builder: (context, favImageProvider, child) {
              return ImageViewAppBar(function: () {
                likeUnlikeImage(favImageProvider);
              });
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          modal.mainBottomSheet(context, downloadOptionList, downloadImage);
        },
        child: Icon(
          Icons.download_sharp,
        ),
      ),
    );
  }
}

class CustomNotificationOnPage extends StatelessWidget {
  final String subTitle;
  final Color iconColor;
  final IconData icon;
  CustomNotificationOnPage(
      {@required this.subTitle, @required this.iconColor, @required this.icon});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 4),
      child: SafeArea(
        child: ListTile(
          leading: SizedBox.fromSize(
            size: Size(40, 40),
            child: Icon(
              icon,
              color: iconColor,
              size: 30,
            ),
          ),
          title: Text(
            'Chitr',
            style: TextStyle(
                fontFamily: 'DancingScript',
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                fontSize: 20),
          ),
          subtitle: Text(subTitle),
          trailing: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                OverlaySupportEntry.of(context).dismiss();
              }),
        ),
      ),
    );
  }
}
