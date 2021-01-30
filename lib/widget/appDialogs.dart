import 'package:flutter/material.dart';

class LodingDialogs {
  static Future showLoadingDialog(
    BuildContext context,
  ) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 4,
                ),
                CircularProgressIndicator(),
                SizedBox(
                  width: 16,
                ),
                Text("Loading"),
              ],
            ),
          ),
        );
      },
    );
  }
}
