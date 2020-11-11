import 'package:chitrwallpaperapp/modal/responeModal.dart';

import 'package:chitrwallpaperapp/widget/appNetWorkImage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../api/networking.dart';
import 'imageView.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  bool get wantKeepAlive => true;
  int pageNumber = 1;
  List<UnPlashResponse> unPlashResponse = [];
  ScrollController _scrollController = ScrollController();

  void getLatestImages(int pageNumber) async {
    try {
      var data = await FetchImages().getLatestImages(pageNumber);
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
    getLatestImages(pageNumber);
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
      body: Padding(
        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
        child: GridView.builder(
            controller: _scrollController,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.6,
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: unPlashResponse.length + 1,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
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
                        userName: item.user.name,
                      ),
                    ));
              }
            }),
      ),
    );
  }
}
