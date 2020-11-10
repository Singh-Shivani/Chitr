import 'package:chitrwallpaperapp/modal/responeModal.dart';
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
  List<UnPlashResponse> unPlashResponse = [];

  ScrollController _scrollController = ScrollController();

  void getTrendingImages(int pageNumber) async {
    try {
      var data = await FetchImages().getTrendingImages(pageNumber);
      setState(() {
        unPlashResponse = data;
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
        unPlashResponse.addAll(data);
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
                  itemCount: unPlashResponse.length + 1,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (index == unPlashResponse.length) {
                      return Center(
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      UnPlashResponse item = unPlashResponse[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ImageView(
                                  unPlashResponse: unPlashResponse[index]),
                            ),
                          );
                        },
                        child: Hero(
                          tag: item.id,
                          child: AppNetWorkImage(
                            imageUrl: item.urls.thumb,
                            blur_hash: item.blurHash,
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
