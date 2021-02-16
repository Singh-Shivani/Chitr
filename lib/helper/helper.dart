import 'package:chitrwallpaperapp/responsive/enums/device_screen_type.dart';
import 'package:chitrwallpaperapp/responsive/utils/ui_utils.dart';
import 'package:flutter/material.dart';

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
}
