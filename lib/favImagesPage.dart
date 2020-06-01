import 'package:flutter/material.dart';
import 'favImagesFunctionPage.dart';
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
    //Used to store the favourites result
    setState(() {
      items = FavImages().getFavImages();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        children: <Widget>[
          (items.length == 0)
              ? Expanded(
                  child: Image.asset('images/Empty-bro.png'),
                )
              : Expanded(
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
                            child: Image.network(
                              items[index][2], //thumb image
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
