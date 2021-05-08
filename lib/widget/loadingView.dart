import 'dart:convert';
import 'package:chitrwallpaperapp/modal/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:progress_indicators/progress_indicators.dart';
import '../helper/helper.dart';

class LoadingView extends StatefulWidget {
  final bool isSliver;

  const LoadingView({Key key, @required this.isSliver}) : super(key: key);

  @override
  _LoadingViewState createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  List<LoadingElement> loading = [];

  _getLoadingData() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/json/loading.json");
    final jsonResult = json.decode(data);
    Loading l = new Loading.fromJson(jsonResult);
    print(jsonResult.length);
    setState(() {
      loading = l.loading;
    });
  }

  Widget loadingItem(LoadingElement loadingElement, int index) {
    return AspectRatio(
      aspectRatio: loadingElement.width / loadingElement.height,
      child: GlowingProgressIndicator(
        duration: Duration(milliseconds: (index + 5) * 100),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.4),
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    _getLoadingData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cellNumber = Helper().getMobileOrientation(context);
    return widget.isSliver
        ? SliverStaggeredGrid.countBuilder(
            crossAxisCount: cellNumber,
            itemCount: loading.length,
            itemBuilder: (BuildContext context, int index) {
              LoadingElement loadingElement = loading[index];
              return Container(
                  margin: EdgeInsets.only(left: 4.0, right: 4.0, top: 8),
                  child: loadingItem(loadingElement, index));
            },
            staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
          )
        : StaggeredGridView.countBuilder(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
            crossAxisCount: cellNumber,
            itemCount: loading.length,
            itemBuilder: (BuildContext context, int index) {
              LoadingElement loadingElement = loading[index];
              return loadingItem(loadingElement, index);
            },
            staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          );
  }
}
