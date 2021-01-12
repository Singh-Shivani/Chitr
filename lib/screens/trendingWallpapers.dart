import 'package:chitrwallpaperapp/modal/responeModal.dart';
import 'package:chitrwallpaperapp/widget/appNetWorkImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../api/networking.dart';
import 'imageView.dart';

class TrendingWallpaperPage extends StatefulWidget {
  @override
  _TrendingWallpaperPageState createState() => _TrendingWallpaperPageState();
}

class _TrendingWallpaperPageState extends State<TrendingWallpaperPage>
    with AutomaticKeepAliveClientMixin<TrendingWallpaperPage> {
  bool get wantKeepAlive => true;
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
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.only(top: 8),
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          controller: _scrollController,
          itemCount: unPlashResponse.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == unPlashResponse.length) {
              return Center(
                child: Container(
                  margin: EdgeInsets.only(top: 24),
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
                      builder: (context) =>
                          ImageView(unPlashResponse: unPlashResponse[index]),
                    ),
                  );
                },
                child: Hero(
                  tag: item.id,
                  child: AppNetWorkImage(
                    blur_hash: item.blurHash,
                    height: item.height,
                    imageUrl: item.urls.thumb,
                    width: item.width,
                  ),
                ),
              );
            }
          },
          staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
        ),
      ),
    );
  }
}
