import 'package:chitrwallpaperapp/helper/theme.dart';
import 'package:chitrwallpaperapp/screens/allCategorys.dart';
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
  PageController pageController;
  final List<Widget> _children = [
    HomePage(),
    TrendingWallpaperPage(),
    AllCategoryScreen(),
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
    setState(() {});
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
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Home".toUpperCase(),
              ),
              Tab(
                text: "Trending".toUpperCase(),
              ),
              Tab(
                text: "Category".toUpperCase(),
              ),
              Tab(
                text: "Like".toUpperCase(),
              ),
            ],
          ),
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
          title: Text(
            "Chitr".toUpperCase(),
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.search,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchedImagePage()),
                  );
                }),
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            ..._children,
          ],
        ),
      ),
    );
  }
}
