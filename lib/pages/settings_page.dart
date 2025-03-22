import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_app/components/my_settings_tile.dart';
import 'package:twitter_app/themes/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text("S E T T I N G S"),
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        children: [
          MySettingsTile(action: CupertinoSwitch(
              onChanged:(value) => Provider.of<ThemeProvider>(context,listen: false).toggle(),
              value: Provider.of<ThemeProvider>(context,listen: false).isDarkMode,
              ), title: "Dark Mode")
        ],
      ),
    );
  }
}