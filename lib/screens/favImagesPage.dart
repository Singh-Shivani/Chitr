import 'package:chitrwallpaperapp/database/dataBaseHelper/database_helper.dart';
import 'package:chitrwallpaperapp/database/data_modal/favImage.dart';
import 'package:chitrwallpaperapp/provider/favImageProvider.dart';
import 'package:chitrwallpaperapp/widget/appNetWorkImage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helper/favImagesFunctionPage.dart';
import 'favImageView.dart';

class FavouriteImagesPage extends StatefulWidget {
  @override
  _FavouriteImagesPageState createState() => _FavouriteImagesPageState();
}

class _FavouriteImagesPageState extends State<FavouriteImagesPage> {
  List items = [];

  @override
  void initState() {
    super.initState();

    setState(() {
      items = FavImages().getFavImages();
    });
  }

  showAlertDialog(BuildContext context, FavImage favImage, favImageProvider) {
    Widget okButton = RaisedButton(
      child: Text("YES"),
      onPressed: () {
        removeFormFav(favImage, favImageProvider);
        Navigator.of(context).pop();
      },
    );
    Widget noButton = FlatButton(
      child: Text("NO"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Remove?"),
      content: Text("Remove form your Favourites."),
      actions: [
        noButton,
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  removeFormFav(FavImage favImage, favImageProvider) async {
    final dbHelper = FavImageDatabaseHelper.instance;
    final hasData = await dbHelper.hasData(favImage.imageid.toString());
    if (hasData) {
      favImageProvider.removeFavImage(favImage.imageid.toString());
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavImageProvider>(
        builder: (context, favImageProvider, child) {
      return Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Center(
              child: Text(
                'LongPress on wallpaper you want\n to remove from Favourites!',
                style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
              ),
            ),
          ),
          (favImageProvider.favImageList.length == 0)
              ? Expanded(child: Image.asset('images/undraw_empty_xct9.png'))
              : Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 20),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.6,
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: favImageProvider.favImageList.length,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (context, index) {
                        FavImage favImage =
                            favImageProvider.favImageList[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FavImageView(
                                  favImage: favImage,
                                ),
                              ),
                            );
                          },
                          child: GestureDetector(
                            onLongPress: () {
                              showAlertDialog(
                                  context, favImage, favImageProvider);
                            },
                            child: AppNetWorkImage(
                              imageUrl: favImage.thumb,
                              blur_hash: favImage.blurHash,
                              height: 2,
                              width: 1,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
        ],
      );
    });
  }
}
