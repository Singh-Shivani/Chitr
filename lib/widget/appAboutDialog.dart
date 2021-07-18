import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helper/theme.dart';

class AppAboutDialog {
  showAppAboutDialog(context) {
    showAboutDialog(
        context: context,
        applicationName: 'Chitr',
        applicationVersion: 'by Shivani Singh\n\nV2.0',
        applicationLegalese: 'All images are provided by unsplash.com',
        children: [
          Consumer<ThemeNotifier>(
            builder: (context, notifier, child) => SwitchListTile(
              title: Text("Dark Mode"),
              onChanged: (val) {
                notifier.toggleTheme(val);
              },
              value: notifier.darkTheme,
            ),
          ),
        ]);
  }
}
