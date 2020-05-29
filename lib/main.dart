import 'package:flutter/material.dart';
import 'homePage.dart';
import 'trendingWallpapers.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'favImagesPage.dart';
import 'searchedImagePage.dart';
import 'package:overlay_support/overlay_support.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainHomePage(),
      ),
    );
  }
}

class MainHomePage extends StatefulWidget {
  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _children = [
    HomePage(),
    TrendingWallpaperPage(),
    FavouriteImagesPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchedImagePage(),
                ),
              );
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
      body: _children[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        color: Color.fromRGBO(224, 220, 218, 0.6),
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.white,
        height: 50,
        index: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: <Widget>[
          Icon(Icons.home, size: 24),
          Icon(Icons.whatshot, size: 24),
          Icon(Icons.favorite, size: 24),
        ],
      ),
    );
  }
}
