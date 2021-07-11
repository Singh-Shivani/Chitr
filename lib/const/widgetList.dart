import 'package:chitrwallpaperapp/modal/deskTopDrawerModal.dart';
import 'package:flutter/material.dart';

List<Widget> mobileTabs = [
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
];

List<DesktopDrawer> desktopTabs = [
  new DesktopDrawer(
    "Home",
    Icons.home,
  ),
  new DesktopDrawer(
    "Trending",
    Icons.whatshot,
  ),
  new DesktopDrawer(
    "Category",
    Icons.book,
  ),
  new DesktopDrawer(
    "Like",
    Icons.thumb_up,
  ),
  new DesktopDrawer(
    "About",
    Icons.info_outline,
  )
];
