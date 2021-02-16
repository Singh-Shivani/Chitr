import 'package:chitrwallpaperapp/helper/helper.dart';
import 'package:chitrwallpaperapp/modal/responeModal.dart';
import 'package:chitrwallpaperapp/widget/appNetWorkImage.dart';
import 'package:chitrwallpaperapp/widget/dismissKeyBoardView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../api/networking.dart';
import 'imageView.dart';

class SearchedImagePage extends StatefulWidget {
  @override
  _SearchedImagePageState createState() => _SearchedImagePageState();
}

class _SearchedImagePageState extends State<SearchedImagePage> {
  String searchText;
  int pageNumber = 1;
  List<UnPlashResponse> unPlashResponse = [];
  var _textController = TextEditingController();
  FocusNode searchFocusNode;
  ScrollController _scrollController = ScrollController();

  void getSearchedImages(
    int pageNumber,
  ) async {
    try {
      var data = await FetchImages()
          .getSearchedImages(pageNumber, _textController.text);
      setState(() {
        unPlashResponse.addAll(data);
      });
    } catch (e) {
      print(e);
    }
  }

  void loadMoreImages(String query) async {
    try {
      pageNumber = pageNumber + 1;
      var data = await FetchImages().getSearchedImages(pageNumber, query);
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
    searchFocusNode = FocusNode();
    searchFocusNode.requestFocus();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadMoreImages(searchText);
      }
    });
  }

  _onStartScroll(ScrollMetrics metrics) {
    Helper().dismissKeyBoard(context);
  }

  @override
  void dispose() {
    _textController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cellNumber = Helper().getMobileOrientation(context);
    return Scaffold(
      body: DismissKeyBoardView(
        child: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollStartNotification) {
              _onStartScroll(scrollNotification.metrics);
            }
          },
          child: CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverAppBar(
                floating: true,
                title: Container(
                  margin: EdgeInsets.symmetric(vertical: 12),
                  height: 44,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  ),
                  child: TextField(
                    focusNode: searchFocusNode,
                    onSubmitted: (value) {
                      searchFocusNode.unfocus();
                      setState(() {
                        searchText = value;
                        getSearchedImages(
                          pageNumber,
                        );
                      });
                    },
                    controller: _textController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      hintText: "Search UnsPlash Images",
                      suffixIcon: IconButton(
                        onPressed: () {
                          _textController.clear();
                          setState(() {
                            searchText = "";
                            unPlashResponse.clear();
                          });
                        },
                        icon: Icon(
                          Icons.clear,
                          color: Color.fromRGBO(13, 26, 59, 1),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              (searchText == null || searchText.isEmpty)
                  ? SliverFillRemaining(
                      child: Center(
                          child: Icon(
                        Icons.search,
                        color: Theme.of(context).accentColor,
                        size: 66,
                      )),
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
                              margin: EdgeInsets.only(
                                  left: 4.0, right: 4.0, top: 8),
                              child: Hero(
                                tag: item.id,
                                child: AppNetWorkImage(
                                  blur_hash: item.blurHash,
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
        ),
      ),
    );
  }
}
