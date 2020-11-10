import 'package:chitrwallpaperapp/modal/responeModal.dart';
import 'package:chitrwallpaperapp/widget/appNetWorkImage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import '../api/networking.dart';
import 'imageView.dart';
import '../main.dart';

class SearchedImagePage extends StatefulWidget {
  @override
  _SearchedImagePageState createState() => _SearchedImagePageState();
}

class _SearchedImagePageState extends State<SearchedImagePage> {
  String searchText;
  int pageNumber = 1;
  List<UnPlashResponse> unPlashResponse = [];
  var _textController = TextEditingController();

  ScrollController _scrollController = ScrollController();

  void getSearchedImages(int pageNumber, String query) async {
    try {
      var data = await FetchImages().getSearchedImages(pageNumber, query);
      setState(() {
        unPlashResponse = data;
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
    getSearchedImages(pageNumber, searchText);

    _scrollController.addListener(() {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        loadMoreImages(searchText);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyApp(),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    margin: EdgeInsets.only(top: 19),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios),
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    margin: EdgeInsets.only(top: 30, bottom: 10),
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        suffixIcon: IconButton(
                          onPressed: () => _textController.clear(),
                          icon: Icon(
                            Icons.clear,
                            color: Color.fromRGBO(13, 26, 59, 1),
                          ),
                        ),
                        hintText: 'Search',
                        hintStyle: TextStyle(letterSpacing: 1),
                      ),
                      onSubmitted: (value) {
                        setState(() {
                          searchText = value;
                          getSearchedImages(pageNumber, searchText);
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          (searchText == null || searchText.isEmpty)
              ? Expanded(
                  child: Text("Search Here"),
                )
              : Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
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
                                        unPlashResponse:
                                            unPlashResponse[index]),
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
                ),
        ],
      ),
    );
  }
}
