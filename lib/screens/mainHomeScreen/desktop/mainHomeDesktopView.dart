import 'package:chitrwallpaperapp/const/widgetList.dart';
import 'package:chitrwallpaperapp/modal/deskTopDrawerModal.dart';
import 'package:chitrwallpaperapp/widget/appAboutDialog.dart';
import 'package:chitrwallpaperapp/widget/chitrGradientText.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import '../../searchedImagePage.dart';

class MainHomeDesktopView extends StatelessWidget {
  final List<Widget> children;
  final int selectedIndex;
  final Function onTap;
  const MainHomeDesktopView(
      {Key key,
      @required this.children,
      @required this.selectedIndex,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: ChitrGradientText(),
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
              ),
            ),
            ...desktopTabs
                .asMap()
                .map((int i, DesktopDrawer element) => MapEntry(
                    i,
                    ListTile(
                      leading: Icon(element.icon),
                      title: Text(element.title.toUpperCase()),
                      onTap: () {
                        if (i == 4) {
                          AppAboutDialog().showAppAboutDialog(context);
                        } else {
                          //scaffoldKey.currentState.openDrawer(),
                          onTap(i, context);
                          scaffoldKey.currentState.openEndDrawer();
                        }
                      },
                    )))
                .values
                .toList()
          ],
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.menu,
            ),
            onPressed: () {
              scaffoldKey.currentState.openDrawer();
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
                  MaterialPageRoute(builder: (context) => SearchedImagePage()),
                );
              }),
        ],
      ),
      body: children[selectedIndex],
    );
  }
}
