import 'package:chitrwallpaperapp/api/networking.dart';
import 'package:chitrwallpaperapp/modal/topic.dart';
import 'package:chitrwallpaperapp/screens/topicImagesScreen.dart';
import 'package:chitrwallpaperapp/widget/appNetWorkImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class AllCategoryScreen extends StatefulWidget {
  @override
  _AllCategoryScreenState createState() => _AllCategoryScreenState();
}

class _AllCategoryScreenState extends State<AllCategoryScreen>
    with AutomaticKeepAliveClientMixin<AllCategoryScreen> {
  bool get wantKeepAlive => true;
  int pageNumber = 1;
  List<Topics> topicsList = [];

  void getCategory(int pageNumber) async {
    try {
      var data = await FetchImages().getCategory();
      setState(() {
        topicsList = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCategory(pageNumber);
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 4, left: 6, right: 6),
      child: topicsList.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : StaggeredGridView.countBuilder(
              // physics: BouncingScrollPhysics(),
              crossAxisCount: 4,
              itemCount: topicsList.length,
              itemBuilder: (BuildContext context, int index) {
                Topics topics = topicsList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TopicImagesScreen(topics: topics),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Hero(
                        tag: topics.id,
                        child: AppNetWorkImage(
                          blur_hash: topics.coverPhoto.blurHash,
                          height: topics.coverPhoto.height,
                          imageUrl: topics.coverPhoto.urls.small,
                          width: topics.coverPhoto.width,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Text(
                          topics.title,
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    ],
                  ),
                );
              },
              staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
    );
  }
}
