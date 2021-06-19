import 'package:chitrwallpaperapp/widget/CustomNotificationOnPage.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class InAppNotification {
  imageDownloaded(
      BuildContext context, IconData iconData, Color color, String message) {
    return showOverlayNotification((context) {
      return CustomNotificationOnPage(
        icon: iconData,
        iconColor: color,
        subTitle: message,
      );
    }, duration: Duration(milliseconds: 3000));
  }

  imageDownloadFailed(BuildContext context, IconData iconData, String message) {
    showOverlayNotification((context) {
      return CustomNotificationOnPage(
          icon: iconData, iconColor: Colors.black, subTitle: message);
    }, duration: Duration(milliseconds: 3000));
  }
}
