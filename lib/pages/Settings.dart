/**
 * THIS IS AN EXAMPLE PAGE PLEASE DO NOT EDIT OR DELETE
 */

import 'package:flutter/material.dart';
import 'package:irish_public_transport_app/elements/sidemenu.dart';
import 'package:irish_public_transport_app/elements/topBar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:toast/toast.dart';

class Settings extends StatefulWidget {
  Settings({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  final storage = new FlutterSecureStorage();
  bool autoRefresh = true;
  Future loadSettings() async {
    String value = await storage.read(key: "Setting_AutoRefresh");
    setState(() {
      autoRefresh = value == "true";
    });
  }

  Future saveSetting(setting, value) async {
    await storage.write(key: setting.toString(), value: value.toString());
    Toast.show("Settings updated!", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
    setState(() {
      autoRefresh = value;
    });
  }

  @override
  void initState() {
    loadSettings();
  }

  @override
  Widget build(BuildContext context) {

    final topAppBar = topBar.get(context, 'Settings');

    return Scaffold(
        appBar: topAppBar,
        drawer: sidemenu.getMenu(context),
        body: new Material(
            child: new Card(
                child: new SwitchListTile(
                  value: autoRefresh,
                  title: Text("Auto refresh realtime information?"),
                  onChanged: (value) {
                    saveSetting("Setting_AutoRefresh", value);
                  },
                ))
        ));
  }
}
