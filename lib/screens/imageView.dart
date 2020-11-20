import 'package:cached_network_image/cached_network_image.dart';
import 'package:chitrwallpaperapp/database/dataBaseHelper/database_helper.dart';
import 'package:chitrwallpaperapp/database/data_modal/favImage.dart';
import 'package:chitrwallpaperapp/modal/responeModal.dart';
import 'package:chitrwallpaperapp/provider/favImageProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ImageView extends StatelessWidget {
  final UnPlashResponse unPlashResponse;
  bool existence;

  ImageView({this.unPlashResponse});

  final dbHelper = FavImageDatabaseHelper.instance;

  Future<bool> downloadImage(String imageUrl) async {
    try {
      // Saved with this method.
      var imageId = await ImageDownloader.downloadImage(
        imageUrl,
        destination: AndroidDestinationType.directoryPictures,
      );
      if (imageId == null) {
        print(null);
      }
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

  Future<bool> addToFav(bool isLiked) async {
    // existence = FavImages().addFavImages(unPlashResponse);
    final hasData = await dbHelper.hasData(unPlashResponse.id.toString());

    if (hasData == true) {
      showOverlayNotification((context) {
        return CustomNotificationOnPage(
          icon: Icons.favorite,
          iconColor: Colors.black,
          subTitle: 'This image is already in your Favourites.',
        );
      }, duration: Duration(milliseconds: 3000));
    } else {
      showOverlayNotification((context) {
        return CustomNotificationOnPage(
          icon: Icons.favorite,
          iconColor: Color.fromRGBO(245, 7, 59, 1),
          subTitle: 'Image added in your Favourites.',
        );
      }, duration: Duration(milliseconds: 3000));
    }
    return !isLiked;
  }

  selectImage(parentContext) {
    return showDialog(
      context: parentContext,
      builder: (context) {
        return SimpleDialog(
          title: Text("Download Image"),
          children: <Widget>[
            SimpleDialogOption(
                child: Text("Small"),
                onPressed: () {
                  downloadImage(unPlashResponse.urls.small);
                  Navigator.pop(context);
                }),
            SimpleDialogOption(
                child: Text("Regular"),
                onPressed: () {
                  downloadImage(unPlashResponse.urls.regular);
                  Navigator.pop(context);
                }),
            SimpleDialogOption(
                child: Text("Full"),
                onPressed: () {
                  downloadImage(unPlashResponse.urls.full);
                  Navigator.pop(context);
                }),
            SimpleDialogOption(
                child: Text("Raw"),
                onPressed: () {
                  downloadImage(unPlashResponse.urls.raw);
                  Navigator.pop(context);
                }),
            Consumer<FavImageProvider>(
                builder: (context, favImageProvider, child) {
              return SimpleDialogOption(
                  child: Text("Like Image"),
                  onPressed: () async {
                    final dbHelper = FavImageDatabaseHelper.instance;
                    final hasData =
                        await dbHelper.hasData(unPlashResponse.id.toString());
                    if (!hasData) {
                      FavImage favImage = new FavImage(
                        unPlashResponse.id.toString(),
                        unPlashResponse.urls.raw,
                        unPlashResponse.urls.full,
                        unPlashResponse.urls.regular,
                        unPlashResponse.urls.small,
                        unPlashResponse.urls.thumb,
                        unPlashResponse.blurHash,
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
                          subTitle:
                              'Image is already added to your Favourites.',
                        );
                      }, duration: Duration(milliseconds: 3000));
                    }
                    Navigator.pop(context);
                  });
            }),
            SimpleDialogOption(
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: unPlashResponse.id,
            child: InteractiveViewer(
              child: CachedNetworkImage(
                imageUrl: unPlashResponse.urls.small,
                imageBuilder: (context, imageProvider) => Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
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
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          selectImage(context);
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
