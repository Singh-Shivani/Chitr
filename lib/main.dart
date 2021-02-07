import 'package:chitrwallpaperapp/helper/theme.dart';
import 'package:chitrwallpaperapp/provider/favImageProvider.dart';
import 'package:chitrwallpaperapp/screens/mainHomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<FavImageProvider>(
              create: (context) => FavImageProvider()),
        ],
        child: ChangeNotifierProvider(
          create: (_) => ThemeNotifier(),
          child: Consumer<ThemeNotifier>(
            builder: (context, ThemeNotifier notifier, child) {
              return MaterialApp(
                title: 'Chitr',
                theme: notifier.darkTheme ? dark : light,
                home: MainHomePage(),
              );
            },
          ),
        ),
      ),
    );
  }
}
