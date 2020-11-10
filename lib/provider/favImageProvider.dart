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

  void addImageToFav(FavImage listItem) {
    Map<String, dynamic> favImageItem = {
      "imageid": listItem.imageid,
      "smallImage": listItem.smallImage,
      "fullImage": listItem.fullImage,
      "dwonloadLink": listItem.dwonloadLink,
    };
    final dbHelper = FavImageDatabaseHelper.instance;
    dbHelper.insert(favImageItem);
    updateProviderData();
  }

  Future<void> updateProviderData() async {
    final dbHelper = FavImageDatabaseHelper.instance;
    final allRows = await dbHelper.queryAllRows();
    print('query all rows: PROVIDER');
    // print(allRows[0]);
    if (allRows.length != 0) {
      // print(allRows[0]);
      for (int i = 0; i < allRows.length; i++) {
        FavImage favSongMobileData = new FavImage(
            allRows[i]['imageid'],
            allRows[i]['smallImage'],
            allRows[i]['fullImage'],
            allRows[i]['dwonloadLink']);
        favImageList.add(favSongMobileData);
      }
      notifyListeners();
    } else {
      print('query all NO DATA:');
      notifyListeners();
    }
  }
}
