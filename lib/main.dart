import 'package:flutter/material.dart';
import 'homePage.dart';
import 'trendingWallpapers.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'favImagesPage.dart';
import 'searchedImagePage.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:gradient_text/gradient_text.dart';

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
        title: Padding(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  showAboutDialog(
                    context: context,
                    applicationName: 'Chitr',
                    applicationVersion: 'by Shivani Singh\n\nV1.0',
                    applicationLegalese:
                        'All images are provided by unsplash.com',
                  );
                },
                child: Icon(
                  Icons.info_outline,
                  color: Colors.black,
                ),
              ),
              GradientText("Chitr",
                  gradient: LinearGradient(colors: [
                    Color.fromRGBO(254, 225, 64, 1),
//                    Color.fromRGBO(250, 112, 154, 1),
                    Color.fromRGBO(245, 87, 108, 1),
//                    Color.fromRGBO(240, 147, 251, 1),
                  ]),
                  style: TextStyle(
                    fontSize: 47,
                    fontFamily: 'DancingScript',
//                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                  textAlign: TextAlign.center),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchedImagePage()),
                  );
                },
                child: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
      body: _children[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        color: Color.fromRGBO(227, 222, 220, 0.65),
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
