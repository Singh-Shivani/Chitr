import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'networking.dart';
import 'imageView.dart';
import 'main.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10),
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
                    margin: EdgeInsets.only(top: 30),
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
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    margin: EdgeInsets.only(top: 40, bottom: 10),
                    child: TextField(
                      controller: _textController,
                      cursorColor: Color.fromRGBO(13, 26, 59, 1),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        suffixIcon: IconButton(
                          onPressed: () => _textController.clear(),
                          icon: Icon(
                            Icons.clear,
                            color: Color.fromRGBO(13, 26, 59, 1),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(13, 26, 59, 0.8), width: 2),
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
                  child: Center(child: Text('Nothing to Show')),
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
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    items[index][2], //thumb image
                                    fit: BoxFit.cover,
                                  ),
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
