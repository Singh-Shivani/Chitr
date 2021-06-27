import 'package:chitrwallpaperapp/responsive/enums/device_screen_type.dart';
import 'package:chitrwallpaperapp/responsive/utils/ui_utils.dart';
import 'package:chitrwallpaperapp/widget/CustomNotificationOnPage.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class InAppNotification {
  imageDownloaded(
      BuildContext context, IconData iconData, Color color, String message) {
    var mediaQuery = MediaQuery.of(context);
    DeviceScreenType deviceScreenType = getDeviceType(mediaQuery);
    return showOverlayNotification(
      (context) {
        return CustomNotificationOnPage(
          icon: iconData,
          iconColor: color,
          subTitle: message,
        );
      },
      duration: Duration(milliseconds: 3000),
      position: deviceScreenType == DeviceScreenType.Desktop
          ? NotificationPosition.bottom
          : NotificationPosition.top,
    );
  }

  imageDownloadFailed(BuildContext context, IconData iconData, String message) {
    var mediaQuery = MediaQuery.of(context);
    DeviceScreenType deviceScreenType = getDeviceType(mediaQuery);
    showOverlayNotification(
      (context) {
        return CustomNotificationOnPage(
            icon: iconData, iconColor: Colors.black, subTitle: message);
      },
      duration: Duration(milliseconds: 3000),
      position: deviceScreenType == DeviceScreenType.Desktop
          ? NotificationPosition.bottom
          : NotificationPosition.top,
    );
  }
}
