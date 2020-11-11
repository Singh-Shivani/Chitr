import 'package:chitrwallpaperapp/modal/responeModal.dart';

import 'package:chitrwallpaperapp/widget/appNetWorkImage.dart';
import 'package:chitrwallpaperapp/widget/imageNotFound.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    getSearchedImages(pageNumber, searchText);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadMoreImages(searchText);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextField(
                            onSubmitted: (value) {
                              setState(() {
                                searchText = value;
                                getSearchedImages(pageNumber, searchText);
                              });
                            },
                            controller: _textController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              fillColor: Color(0xfff3f3f4),
                              filled: true,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  _textController.clear();
                                  setState(() {
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
                        ],
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
                          physics: const BouncingScrollPhysics(),
                          controller: _scrollController,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.6,
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                          ),
                          itemCount: unPlashResponse.length + 1,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            if (index == unPlashResponse.length) {
                              return Center(
                                child: SizedBox(
                                  // width: 30,
                                  // height: 30,
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
                                    userName: item.user.name,
                                  ),
                                ),
                              );
                            }
                          }),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
