import 'package:chitrwallpaperapp/responsive/enums/device_screen_type.dart';
import 'package:chitrwallpaperapp/responsive/utils/ui_utils.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Helper {
  getMobileOrientation(context) {
    int cellCount = 4;
    var mediaQuery = MediaQuery.of(context);
    DeviceScreenType deviceScreenType = getDeviceType(mediaQuery);
    var orientation = mediaQuery.orientation;
    if (deviceScreenType == DeviceScreenType.Mobile) {
      cellCount = orientation == Orientation.portrait ? 4 : 8;
    } else if (deviceScreenType == DeviceScreenType.Tablet) {
      cellCount = 8;
    }
    return cellCount;
  }

  dismissKeyBoard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  saveReponse(String key, String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, data);
    print(prefs);

    return true;
  }

  getSavedResponse(String key) async {
    String stringValue;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    stringValue = prefs.getString(key);
    return stringValue;
  }

  Future<bool> hasConnection() async {
    bool result = await DataConnectionChecker().hasConnection;
    if (result == true) {
      return true;
    } else {
      print(DataConnectionChecker().lastTryResults);
      return false;
    }
  }

  showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
