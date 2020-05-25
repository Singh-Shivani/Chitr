import 'package:flutter/material.dart';
import 'networking.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageNumber = 1;
  List items = [];

  ScrollController _scrollController = ScrollController();

  void getLatestImages(int pageNumber) async {
    try {
      var data = await FetchImages().getLatestImages(pageNumber);
      setState(() {
        items = data;
      });
    } catch (e) {
      print(e);
    }
  }

  void loadMoreImages(int pageNumber) async {
    try {
      pageNumber = pageNumber + 1;
      var data = await FetchImages().getLatestImages(pageNumber);
      setState(() {
        items.addAll(data);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getLatestImages(pageNumber);
    _scrollController.addListener(() {
      if (_scrollController.offset >=
              _scrollController.position.minScrollExtent &&
          !_scrollController.position.outOfRange) {
        loadMoreImages(pageNumber);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
        title: Text(
          'Chitr',
          style: TextStyle(
              fontFamily: 'DancingScript',
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 50),
        ),
      ),
//      backgroundColor: Color.fromRGBO(37, 43, 51, 1),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              GridView.builder(
                  controller: _scrollController,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
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
                      return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            items[index][2],
                            fit: BoxFit.cover,
                          ));
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
