import 'package:chitrwallpaperapp/database/dataBaseHelper/database_helper.dart';
import 'package:chitrwallpaperapp/database/data_modal/favImage.dart';
import 'package:flutter/material.dart';

class FavImageProvider with ChangeNotifier {
  List<FavImage> favImageList = [];

  FavImageProvider() {
    updateProviderData();
  }

  void updateFavImageList() {
    favImageList.clear();
    updateProviderData();
  }

  void removeFavImage(imageId) {
    final dbHelper = FavImageDatabaseHelper.instance;
    dbHelper.deleteFav(imageId);
    updateProviderData();
  }

  void addImageToFav(FavImage listItem) {
    Map<String, dynamic> favImageItem = {
      "imageid": listItem.imageid,
      "raw": listItem.raw,
      "full": listItem.full,
      "regular": listItem.regular,
      "small": listItem.small,
      "thumb": listItem.thumb,
      "blurHash": listItem.blurHash
    };
    final dbHelper = FavImageDatabaseHelper.instance;
    dbHelper.insert(favImageItem);
    updateProviderData();
  }

  Future<void> updateProviderData() async {
    favImageList.clear();
    final dbHelper = FavImageDatabaseHelper.instance;
    final allRows = await dbHelper.queryAllRows();
    if (allRows.length != 0) {
      for (int i = 0; i < allRows.length; i++) {
        FavImage favSongMobileData = new FavImage(
            allRows[i]['imageid'],
            allRows[i]['raw'],
            allRows[i]['full'],
            allRows[i]['regular'],
            allRows[i]['small'],
            allRows[i]['thumb'],
            allRows[i]['blurHash']);
        favImageList.add(favSongMobileData);
        notifyListeners();
      }
    } else {
      print('No Image Found');
      notifyListeners();
    }
  }
}
