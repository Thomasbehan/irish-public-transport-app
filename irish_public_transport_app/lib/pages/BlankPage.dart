/**
 * THIS IS AN EXAMPLE PAGE PLEASE DO NOT EDIT OR DELETE
 */

import 'Routes.dart';
import 'package:flutter/material.dart';
import 'package:irish_public_transport_app/elements/sidemenu.dart';

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

    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: Color.fromRGBO(45, 150, 255, 1.0),
      title: Text('IPT EXAMPLE PAGE'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Routes()),
            );
          },
        )
      ],
    );

    return Scaffold(
        appBar: topAppBar,
        drawer: sidemenu.getMenu(),
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
