import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:like_button/like_button.dart';
import 'favImagesFunctionPage.dart';
import 'package:image_downloader/image_downloader.dart';

class ImageView extends StatelessWidget {
  final List items;
  final int index;
  ImageView({this.index, this.items});
  Future<bool> downloadImage(bool isLiked) async {
    try {
      // Saved with this method.
      var imageId = await ImageDownloader.downloadImage(
        items[3],
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

//      toast('Downloaded!');
    } on PlatformException catch (error) {
//      toast("Sorry, couldn't download");
      print(error);
    }

    return !isLiked;
  }

  Future<bool> addToFav(bool isLiked) async {
    FavImages().addFavImages(items);
//    toast('Added to Favs!');
    return !isLiked;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: items[index],
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                items[index][1],
              ),
              fit: BoxFit.cover,
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
                    LikeButton(
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.cloud_download,
                          color: isLiked
                              ? Color.fromRGBO(108, 99, 255, 1)
                              : Colors.black54,
                          size: 30,
                        );
                      },
                      onTap: downloadImage,
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
                      onTap: addToFav,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 30,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
