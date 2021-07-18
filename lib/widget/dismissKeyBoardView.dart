import 'package:chitrwallpaperapp/helper/helper.dart';
import 'package:flutter/material.dart';

class DismissKeyBoardView extends StatelessWidget {
  final Widget child;
  const DismissKeyBoardView({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Helper().dismissKeyBoard(context);
      },
      child: child,
    );
  }
}
