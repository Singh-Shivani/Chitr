import 'package:chitrwallpaperapp/helper/theme.dart';
import 'package:chitrwallpaperapp/screens/favImagesPage.dart';
import 'package:chitrwallpaperapp/screens/homePage.dart';
import 'package:chitrwallpaperapp/screens/searchedImagePage.dart';
import 'package:chitrwallpaperapp/screens/trendingWallpapers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainHomePage extends StatefulWidget {
  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int _selectedIndex = 0;
  PageController pageController;
  final List<Widget> _children = [
    HomePage(),
    TrendingWallpaperPage(),
    FavouriteImagesPage(),
  ];

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this._selectedIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

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
                  applicationLegalese:
                      'All images are provided by unsplash.com',
                  children: [
                    Consumer<ThemeNotifier>(
                      builder: (context, notifier, child) => SwitchListTile(
                        title: Text("Dark Mode"),
                        onChanged: (val) {
                          notifier.toggleTheme();
                        },
                        value: notifier.darkTheme,
                      ),
                    ),
                  ]);
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
      body: PageView(
        children: <Widget>[
          ..._children,
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.whatshot),
            label: 'Trending ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.thumb_up),
            label: 'Liked',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: onTap,
      ),
    );
  }
}
