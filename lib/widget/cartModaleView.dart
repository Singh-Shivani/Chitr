import 'package:chitrwallpaperapp/modal/downloadOption.dart';
import 'package:flutter/material.dart';
import 'package:filesize/filesize.dart';

class Modal {
  mainBottomSheet(BuildContext context, List<DownloadOption> downloadOptionList,
      Function downloadImage) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Container(
              color: Colors.transparent,
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 14.0),
                    child: Text(
                      "Download Options",
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ...downloadOptionList.asMap().entries.map((MapEntry map) {
                    return _createTile(
                        context,
                        downloadOptionList[map.key].type,
                        filesize(downloadOptionList[map.key].fileSize), () {
                      downloadImage(downloadOptionList[map.key].url);
                    });
                  }).toList(),
                ],
              ),
            ),
          );
        });
  }

  ListTile _createTile(
      BuildContext context, String title, String prise, Function action) {
    return ListTile(
      leading: new Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: Color(0xff000000),
        ),
      ),
      trailing: new Text(
        prise,
        textAlign: TextAlign.right,
      ),
      onTap: () {
        Navigator.pop(context);
        action();
      },
    );
  }
}
