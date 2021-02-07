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
    return topicsList.length == 0
        ? Center(
            child: CircularProgressIndicator(),
          )
        : StaggeredGridView.countBuilder(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
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
                child: Stack(
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
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4)),
                        color: Colors.black.withOpacity(0.4),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        topics.title,
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    )
                  ],
                ),
              );
            },
            staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          );
  }
}
