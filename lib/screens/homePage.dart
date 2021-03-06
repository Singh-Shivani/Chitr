import 'dart:async';
import 'dart:convert';
import 'package:chitrwallpaperapp/helper/helper.dart';
import 'package:chitrwallpaperapp/modal/responeModal.dart';
import 'package:chitrwallpaperapp/widget/appNetWorkImage.dart';
import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../api/networking.dart';
import 'imageView.dart';
import 'package:chitrwallpaperapp/const/constants.dart' as Constants;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  bool get wantKeepAlive => true;
  int pageNumber = 1;
  List<UnPlashResponse> unPlashResponse = [];
  ScrollController _scrollController = ScrollController();
  bool isOffline = false;

  StreamSubscription _connectionChangeStream;

  void getLatestImages(int pageNumber) async {
    if (isOffline && await Helper().hasConnection() != true) {
      getLocalSavedData();
      return;
    } else {
      try {
        var data = await FetchImages().getLatestImages(pageNumber);

        setState(() {
          unPlashResponse = data;
        });
        saveDataToLocal(json.encode(data));
      } catch (e) {
        getLocalSavedData();

        print(e);
      }
    }
  }

  Future<void> getLocalSavedData() async {
    var saveData = await Helper().getSavedResponse(Constants.OFFLINE_SHOW_KEY);
    if (saveData != null) {
      var data = jsonDecode(saveData);
      for (var i = 0; i < data.length; i++) {
        UnPlashResponse item = new UnPlashResponse.fromJson(data[i]);
        setState(() {
          unPlashResponse.add(item);
        });
      }
    } else {
      Helper().showToast("No Offine Data To Show");
    }
  }

  void saveDataToLocal(String data) {
    Helper().saveReponse(Constants.OFFLINE_SHOW_KEY, data);
  }

  void loadMoreImages() async {
    try {
      pageNumber = pageNumber + 1;
      var data = await FetchImages().getLatestImages(pageNumber);
      setState(() {
        unPlashResponse.addAll(data);
      });
      saveDataToLocal(json.encode(unPlashResponse));
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        loadMoreImages();
      }
    });
    _connectionChangeStream = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result != ConnectivityResult.none) {
        bool hasConection = await DataConnectionChecker().hasConnection;
        setState(() {
          isOffline = !hasConection;
        });
      }
    });
    getLatestImages(pageNumber);
  }

  @override
  void dispose() {
    _connectionChangeStream.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    var cellNumber = Helper().getMobileOrientation(context);
    return StaggeredGridView.countBuilder(
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
      crossAxisCount: cellNumber,
      controller: _scrollController,
      itemCount: unPlashResponse.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == unPlashResponse.length) {
          return Center(
            child: Container(
              margin: EdgeInsets.only(top: 24),
              width: 30,
              height: 30,
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          UnPlashResponse item = unPlashResponse[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ImageView(unPlashResponse: unPlashResponse[index]),
                ),
              );
            },
            child: Hero(
              tag: item.id,
              child: AppNetWorkImage(
                blur_hash: item.blurHash,
                height: item.height,
                imageUrl: item.urls.small,
                width: item.width,
              ),
            ),
          );
        }
      },
      staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
    );
  }
}
