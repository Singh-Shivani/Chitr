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
  List items;
  var _textController = TextEditingController();

  ScrollController _scrollController = ScrollController();

  void getSearchedImages(int pageNumber, String query) async {
    try {
      var data = await FetchImages().getSearchedImages(pageNumber, query);
      setState(() {
        items = data;
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
        items.addAll(data);
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

  Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      hint: 'Search...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      maxWidth: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {},
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.place),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: Colors.accents.map((color) {
                return Container(height: 112, color: color);
              }).toList(),
            ),
          ),
        );
      },
    );
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
                        itemCount: items.length + 1,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemBuilder: (context, index) {
                          if (index == items.length) {
                            return Center(
                              child: SizedBox(
                                width: 30,
                                height: 30,
                                child: CircularProgressIndicator(),
                              ),
                            );
                          } else {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ImageView(items: items[index]),
                                  ),
                                );
                              },
                              child: Hero(
                                tag: items[index],
                                child: AppNetWorkImage(
                                  imageUrl: items[index][2],
                                  blur_hash: items[index][1],
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
