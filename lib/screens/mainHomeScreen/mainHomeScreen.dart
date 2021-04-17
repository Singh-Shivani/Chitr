import 'package:chitrwallpaperapp/screens/allCategorys.dart';
import 'package:chitrwallpaperapp/screens/favImagesPage.dart';
import 'package:chitrwallpaperapp/screens/homePage.dart';
import 'package:chitrwallpaperapp/screens/mainHomeScreen/desktop/mainHomeDesktopView.dart';
import 'package:chitrwallpaperapp/screens/mainHomeScreen/mobileView/mainHomeMobileView.dart';
import 'package:chitrwallpaperapp/screens/trendingWallpapers.dart';
import 'package:flutter/material.dart';
import '../../helper/helper.dart';
import '../../responsive/enums/device_screen_type.dart';
import '../../responsive/responsive/screen_type_layout.dart';

class MainHomePage extends StatefulWidget {
  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  PageController pageController;
  int selectedIndex = 0;
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

  onTap(int pageIndex, context) {
    print("hHH");
    if (Helper().getPlatformType(context) == DeviceScreenType.Desktop) {
      setState(() {
        selectedIndex = pageIndex;
      });
    } else {
      pageController.animateToPage(
        pageIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
        mobile: MainHomeMobileView(
          children: _children,
        ),
        desktop: MainHomeDesktopView(
            selectedIndex: selectedIndex, children: _children, onTap: onTap));
  }
}
