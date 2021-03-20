import 'package:chitrwallpaperapp/helper/helper.dart';
import 'package:chitrwallpaperapp/modal/responeModal.dart';
import 'package:chitrwallpaperapp/modal/topic.dart';
import 'package:chitrwallpaperapp/widget/appNetWorkImage.dart';
import 'package:chitrwallpaperapp/widget/gradientAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../api/networking.dart';
import 'imageView.dart';

class TopicImagesScreen extends StatefulWidget {
  final Topics topics;

  const TopicImagesScreen({Key key, @required this.topics}) : super(key: key);
  @override
  _TopicImagesScreenState createState() => _TopicImagesScreenState();
}

class _TopicImagesScreenState extends State<TopicImagesScreen> {
  String searchText;
  int pageNumber = 1;
  List<UnPlashResponse> unPlashResponse = [];
  var _textController = TextEditingController();

  ScrollController _scrollController = ScrollController();

  void getTopic(String topicId) async {
    try {
      var data = await FetchImages().getTopicImage(pageNumber, topicId);
      setState(() {
        unPlashResponse.addAll(data);
      });
    } catch (e) {
      print(e);
    }
  }

  void loadMoreImages(String topicId) async {
    try {
      pageNumber = pageNumber + 1;
      var data = await FetchImages().getTopicImage(pageNumber, topicId);
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
    getTopic(widget.topics.id);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadMoreImages(widget.topics.id);
      }
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cellNumber = Helper().getMobileOrientation(context);
    var isTablet = Helper().isTablet(context);
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          AppAppbar(
            title: widget.topics.title,
            imageUrl: isTablet
                ? widget.topics.coverPhoto.urls.regular
                : widget.topics.coverPhoto.urls.small,
            subTitle: widget.topics.description,
            blurHash: widget.topics.coverPhoto.blurHash,
            height: widget.topics.coverPhoto.height,
            width: widget.topics.coverPhoto.width,
          ),
          unPlashResponse == null
              ? SliverToBoxAdapter(
                  child: Center(
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 24),
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                )
              : SliverStaggeredGrid.countBuilder(
                  crossAxisCount: cellNumber,
                  itemCount: unPlashResponse.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == unPlashResponse.length) {
                      return Center(
                        child: Center(
                          child: Container(
                            margin: EdgeInsets.only(top: 24),
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(),
                          ),
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
                        child: Container(
                          margin:
                              EdgeInsets.only(left: 4.0, right: 4.0, top: 8),
                          child: Hero(
                            tag: item.id,
                            child: AppNetWorkImage(
                              blurHash: item.blurHash,
                              height: item.height,
                              imageUrl: item.urls.small,
                              width: item.width,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
                ),
        ],
      ),
    );
  }
}
