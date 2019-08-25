/**
 * THIS IS AN EXAMPLE PAGE PLEASE DO NOT EDIT OR DELETE
 */

import 'package:flutter/material.dart';
import 'package:irish_public_transport_app/elements/sidemenu.dart';
import 'package:irish_public_transport_app/elements/topBar.dart';

class BlankPage extends StatefulWidget {
  BlankPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BlankPageState createState() => _BlankPageState();
}

class _BlankPageState extends State<BlankPage> {

  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {

    final topAppBar = topBar.get(context, 'IPT');

    return Scaffold(
        appBar: topAppBar,
        drawer: sidemenu.getMenu(context),
        body: new Material(
            child: new Card(
                        child: new ListTile(
                            title: new Text("This is an Example Page."),
                            subtitle: new Text("Please do not delete or edit this page."),
                            leading: new CircleAvatar(
                              child: new Text("TEST")
                            )))
            ));
  }
}
