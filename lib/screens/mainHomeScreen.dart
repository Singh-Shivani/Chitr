import 'package:chitrwallpaperapp/screens/favImagesPage.dart';
import 'package:chitrwallpaperapp/screens/homePage.dart';
import 'package:chitrwallpaperapp/screens/searchedImagePage.dart';
import 'package:chitrwallpaperapp/screens/trendingWallpapers.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.info_outline,
            ),
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationName: 'Chitr',
                applicationVersion: 'by Shivani Singh\n\nV1.0',
                applicationLegalese: 'All images are provided by unsplash.com',
              );
            }),
        centerTitle: true,
        elevation: 0.0,
        title: Text("Chitr"),
        actions: [
          IconButton(
              icon: Icon(
                Icons.search,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchedImagePage()),
                );
              }),
        ],
      ),
      body: _children[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.whatshot),
            label: 'Trnading',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.thumb_up),
            label: 'Liked',
          ),
        ],
        currentIndex: _selectedIndex,
        // selectedItemColor: Colors.amber[800],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
