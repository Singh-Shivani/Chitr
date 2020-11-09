import 'package:chitrwallpaperapp/widget/appNetWorkImage.dart';
import 'package:flutter/material.dart';
import '../helper/favImagesFunctionPage.dart';
import 'imageView.dart';

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

  @override
  Widget build(BuildContext context) {
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
        (items.length == 0)
            ? Expanded(child: Image.asset('images/undraw_empty_xct9.png'))
            : Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.6,
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: items.length,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ImageView(items: items[index]),
                            ),
                          );
                        },
                        child: GestureDetector(
                          onLongPress: () {
                            setState(() {
                              FavImages().removeFavImages(items[index]);
                            });
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: AppNetWorkImage(
                              imageUrl: items[index][2],
                              blur_hash: items[index][1],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
      ],
    );
  }
}
