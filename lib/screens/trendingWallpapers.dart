import 'package:chitrwallpaperapp/widget/appNetWorkImage.dart';
import 'package:flutter/material.dart';
import '../api/networking.dart';
import 'imageView.dart';

class TrendingWallpaperPage extends StatefulWidget {
  @override
  _TrendingWallpaperPageState createState() => _TrendingWallpaperPageState();
}

class _TrendingWallpaperPageState extends State<TrendingWallpaperPage> {
  int pageNumber = 1;
  List items = [];

  ScrollController _scrollController = ScrollController();

  void getTrendingImages(int pageNumber) async {
    try {
      var data = await FetchImages().getTrendingImages(pageNumber);
      setState(() {
        items = data;
      });
    } catch (e) {
      print(e);
    }
  }

  void loadMoreImages() async {
    try {
      pageNumber = pageNumber + 1;
      var data = await FetchImages().getLatestImages(pageNumber);
      setState(() {
        items.addAll(data);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getTrendingImages(pageNumber);
    _scrollController.addListener(() {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        loadMoreImages();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.only(top: 8),
        child: Column(
          children: <Widget>[
            Expanded(
              child: GridView.builder(
                  controller: _scrollController,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.6,
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                  ),
                  itemCount: items.length + 1,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (index == items.length) {
                      return Center(
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
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
                        child: Hero(
                          tag: items[index],
                          child: AppNetWorkImage(
                            imageUrl: items[index][2],
                            blur_hash: items[index][1],
                          ),
                        ),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
