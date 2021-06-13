import 'dart:io';
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
import 'package:chitrwallpaperapp/widget/inAppNotificaion.dart';
import 'package:flowder/flowder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:octo_image/octo_image.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:path_provider/path_provider.dart';
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
      if (Platform.isMacOS || Platform.isWindows) {
        // var path = (await getApplicationSupportDirectory()).path;
        var path = (await getDownloadsDirectory()).path;

        print(path);
        var options = DownloaderUtils(
          progressCallback: (current, total) {
            final progress = (current / total) * 100;
            print('Downloading: $progress');
          },
          file: File('$path/' + Helper().getFileName(5)),
          progress: ProgressImplementation(),
          onDone: () => InAppNotification().imageDownloaded(
              context, Icons.done, Theme.of(context).accentColor, 'Downloaded'),
          deleteOnCancel: true,
        );
        await Flowder.download(imageUrl, options);
      } else {
        var imageId = await ImageDownloader.downloadImage(
          imageUrl,
          destination: AndroidDestinationType.directoryPictures,
        );
        if (imageId == null) {}
        InAppNotification().imageDownloaded(
            context, Icons.done, Theme.of(context).accentColor, 'Downloaded');
      }
    } on PlatformException catch (error) {
      InAppNotification().imageDownloaded(
          context, Icons.error_outline, Colors.red, "Sorry, couldn't download");
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
      http.Response r = await http.head(Uri.parse(urls[i]['url']));
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
      InAppNotification().imageDownloaded(context, Icons.favorite,
          Color.fromRGBO(245, 7, 59, 1), 'Image added in your Favourites.');
    } else {
      InAppNotification().imageDownloaded(context, Icons.favorite, Colors.black,
          'Image is already added to your Favourites.');
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
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: OctoImage(
                    image: CachedNetworkImageProvider(
                      widget.unPlashResponse.urls.small,
                    ),
                    placeholderBuilder: (context) => Center(
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
                    errorBuilder: OctoError.icon(color: Colors.red),
                    fit: BoxFit.contain,
                  ),
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
