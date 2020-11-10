import 'package:cached_network_image/cached_network_image.dart';
import 'package:chitrwallpaperapp/modal/responeModal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:like_button/like_button.dart';
import 'package:overlay_support/overlay_support.dart';
import '../helper/favImagesFunctionPage.dart';
import 'package:image_downloader/image_downloader.dart';

class ImageView extends StatelessWidget {
  final UnPlashResponse unPlashResponse;
  bool existence;

  ImageView({this.unPlashResponse});
  Future<bool> downloadImage(bool isLiked) async {
    try {
      // Saved with this method.
      var imageId = await ImageDownloader.downloadImage(
        unPlashResponse.urls.full,
        destination: AndroidDestinationType.directoryPictures,
      );
      if (imageId == null) {
        print(null);
        return !isLiked;
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

    return !isLiked;
  }

  // Future<bool> addToFav(bool isLiked) async {
  //   existence = FavImages().addFavImages(unPlashResponse);
  //   if (existence == true) {
  //     showOverlayNotification((context) {
  //       return CustomNotificationOnPage(
  //         icon: Icons.favorite,
  //         iconColor: Colors.black,
  //         subTitle: 'This image is already in your Favourites.',
  //       );
  //     }, duration: Duration(milliseconds: 3000));
  //   } else {
  //     showOverlayNotification((context) {
  //       return CustomNotificationOnPage(
  //         icon: Icons.favorite,
  //         iconColor: Color.fromRGBO(245, 7, 59, 1),
  //         subTitle: 'Image added in your Favourites.',
  //       );
  //     }, duration: Duration(milliseconds: 3000));
  //   }
  //   return !isLiked;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
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
                  fit: BoxFit.contain,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20)),
                        color: Colors.white70.withOpacity(0.6)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 30,
                            color: Colors.black54,
                          ),
                        ),
                        LikeButton(
                          likeBuilder: (bool isLiked) {
                            return Icon(
                              Icons.favorite,
                              color: isLiked
                                  ? Color.fromRGBO(245, 7, 59, 1)
                                  : Colors.black54,
                              size: 30,
                            );
                          },
                          // onTap: addToFav,
                        ),
                        LikeButton(
                          likeBuilder: (bool isLiked) {
                            return Icon(
                              Icons.cloud_download,
                              color:
                                  isLiked ? Colors.blueAccent : Colors.black54,
                              size: 30,
                            );
                          },
                          onTap: downloadImage,
                        ),
                      ],
                    ),
                  ),
                ],
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
