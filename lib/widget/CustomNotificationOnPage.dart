import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class CustomNotificationOnPage extends StatelessWidget {
  final String subTitle;
  final Color iconColor;
  final IconData icon;
  CustomNotificationOnPage(
      {@required this.subTitle, @required this.iconColor, @required this.icon});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 4),
        child: SafeArea(
          child: ListTile(
            leading: SizedBox.fromSize(
              size: Size(40, 40),
              child: Icon(
                icon,
                color: iconColor,
                size: 30,
              ),
            ),
            title: Text(
              'Chitr',
              style: TextStyle(
                  fontFamily: 'DancingScript',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  fontSize: 20),
            ),
            subtitle: Text(subTitle),
            trailing: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  OverlaySupportEntry.of(context).dismiss();
                }),
          ),
        ),
      ),
    );
  }
}
