import 'package:chitrwallpaperapp/helper/helper.dart';
import 'package:chitrwallpaperapp/modal/responeModal.dart';
import 'package:chitrwallpaperapp/modal/topic.dart';
import 'package:chitrwallpaperapp/widget/appNetWorkImage.dart';
import 'package:chitrwallpaperapp/widget/gradientAppBar.dart';
import 'package:chitrwallpaperapp/widget/loadingIndicator.dart';
import 'package:chitrwallpaperapp/widget/loadingView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../api/networking.dart';
import '../modal/appError.dart';
import '../widget/errorScreen.dart';
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
  ApiError apiError;
  ScrollController _scrollController = ScrollController();
  bool loadMore = true;

  void getTopic(String topicId) async {
    setState(() {
      apiError = null;
    });
    try {
      var data = await FetchImages().getTopicImage(pageNumber, topicId);
      if (data is List<UnPlashResponse>) {
        setState(() {
          unPlashResponse = data;
        });
      } else {
        setState(() {
          apiError = data;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void loadMoreImages(String topicId) async {
    if (loadMore == false) {
      return;
    }
    try {
      pageNumber = pageNumber + 1;
      var data = await FetchImages().getTopicImage(pageNumber, topicId);
      if (data.isEmpty) {
        setState(() {
          loadMore = false;
        });
        return;
      }
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
          unPlashResponse.length == 0
              ? apiError == null
                  ? LoadingView(
                      isSliver: true,
                    )
                  : ErrorScreen(
                      errorMessage: apiError.errors[0],
                      tryAgain: getTopic,
                    )
              : SliverStaggeredGrid.countBuilder(
                  crossAxisCount: cellNumber,
                  itemCount: unPlashResponse.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == unPlashResponse.length) {
                      return LoadingIndicator(
                        isLoading: loadMore,
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
