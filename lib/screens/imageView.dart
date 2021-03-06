import 'package:cached_network_image/cached_network_image.dart';
import 'package:chitrwallpaperapp/database/dataBaseHelper/database_helper.dart';
import 'package:chitrwallpaperapp/database/data_modal/favImage.dart';
import 'package:chitrwallpaperapp/helper/helper.dart';
import 'package:chitrwallpaperapp/modal/downloadOption.dart';
import 'package:chitrwallpaperapp/modal/responeModal.dart';
import 'package:chitrwallpaperapp/provider/favImageProvider.dart';
import 'package:chitrwallpaperapp/widget/appDialogs.dart';
import 'package:chitrwallpaperapp/widget/cartModaleView.dart';
import 'package:chitrwallpaperapp/widget/imageViewAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:provider/provider.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';
import 'package:http/http.dart' as http;

class ImageView extends StatefulWidget {
  final UnPlashResponse unPlashResponse;

  ImageView({this.unPlashResponse});

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  bool existence;
  Modal modal = new Modal();
  final dbHelper = FavImageDatabaseHelper.instance;
  List<DownloadOption> downloadOptionList = [];
  downloadImage(String imageUrl) async {
    try {
      var imageId = await ImageDownloader.downloadImage(
        imageUrl,
        destination: AndroidDestinationType.directoryPictures,
      );
      if (imageId == null) {}
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

  createUrlList() async {
    List urls = [
      {
        "type": "Small",
        "url": widget.unPlashResponse.urls.small,
      },
      {
        "type": "Regular",
        "url": widget.unPlashResponse.urls.regular,
      },
      {
        "type": "Full",
        "url": widget.unPlashResponse.urls.full,
      },
      {"type": "Raw", "url": widget.unPlashResponse.urls.raw}
    ];

    for (var i = 0; i < urls.length; i++) {
      http.Response r = await http.head(urls[i]['url']);
      DownloadOption downloadOption = new DownloadOption(
          urls[i]['url'], urls[i]['type'], r.headers["content-length"]);
      setState(() {
        downloadOptionList.add(downloadOption);
      });
    }
    Navigator.pop(context);
    modal.mainBottomSheet(context, downloadOptionList, downloadImage);
  }

  Future<void> likeUnlikeImage(favImageProvider) async {
    final dbHelper = FavImageDatabaseHelper.instance;
    final hasData =
        await dbHelper.hasData(widget.unPlashResponse.id.toString());
    if (!hasData) {
      FavImage favImage = new FavImage(
        widget.unPlashResponse.id.toString(),
        widget.unPlashResponse.urls.raw,
        widget.unPlashResponse.urls.full,
        widget.unPlashResponse.urls.regular,
        widget.unPlashResponse.urls.small,
        widget.unPlashResponse.urls.thumb,
        widget.unPlashResponse.blurHash,
      );
      favImageProvider.addImageToFav(favImage);
      showOverlayNotification((context) {
        return CustomNotificationOnPage(
          icon: Icons.favorite,
          iconColor: Color.fromRGBO(245, 7, 59, 1),
          subTitle: 'Image added in your Favourites.',
        );
      }, duration: Duration(milliseconds: 3000));
    } else {
      showOverlayNotification((context) {
        return CustomNotificationOnPage(
          icon: Icons.favorite,
          iconColor: Colors.black,
          subTitle: 'Image is already added to your Favourites.',
        );
      }, duration: Duration(milliseconds: 3000));
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
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
              tag: widget.unPlashResponse.id,
              child: InteractiveViewer(
                child: CachedNetworkImage(
                  imageUrl: widget.unPlashResponse.urls.small,
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
          if (downloadOptionList.length == 0) {
            if (await Helper().hasConnection()) {
              LodingDialogs.showLoadingDialog(context);
              createUrlList();
            } else {
              Helper().showToast(
                  "No internet connection can't download image now.");
            }
          } else {
            modal.mainBottomSheet(context, downloadOptionList, downloadImage);
          }
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
    return SafeArea(
      child: Card(
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
      ),
    );
  }
}
