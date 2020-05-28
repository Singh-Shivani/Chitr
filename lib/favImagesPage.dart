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
    return Column(
      children: <Widget>[
        (items.length == 0)
            ? Text('no fav img')
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
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ImageView(items: items, index: index),
                          ),
                        );
                      },
                      child: Hero(
                        tag: items[index],
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
    );
  }
}
