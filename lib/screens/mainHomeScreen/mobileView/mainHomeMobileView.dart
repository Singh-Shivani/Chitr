import 'package:chitrwallpaperapp/const/widgetList.dart';
import 'package:chitrwallpaperapp/widget/appAboutDialog.dart';
import 'package:flutter/material.dart';
import '../../searchedImagePage.dart';

class MainHomeMobileView extends StatelessWidget {
  final List<Widget> children;
  const MainHomeMobileView({Key key, @required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: mobileTabs,
          ),
          leading: IconButton(
              icon: Icon(
                Icons.info_outline,
              ),
              onPressed: () {
                AppAboutDialog().showAppAboutDialog(context);
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
            ...children,
          ],
        ),
      ),
    );
  }
}
