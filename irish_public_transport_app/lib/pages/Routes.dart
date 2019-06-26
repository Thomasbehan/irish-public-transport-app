import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:screen/screen.dart';

class Routes extends StatefulWidget {
  Routes({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RoutesState createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  TextEditingController controller = new TextEditingController();
  String filter;

  void keepScreenOn() {
    // Prevent screen from going into sleep mode:
    Screen.keepOn(true);
  }

  final topAppBar = AppBar(
    elevation: 0.1,
    backgroundColor: Color.fromRGBO(52, 80, 92, 1.0),
    title: Text('IPT ALPHA'),
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {},
      )
    ],
  );

  List routes = [];

  Future<List> _getRoutes() async {
    keepScreenOn();
    var data = await http.get(
        'https://data.smartdublin.ie/cgi-bin/rtpi/routelistinformation?format=json',
        headers: {"Accept": "application/json"});

    setState(() {
      print(data);
      var jsonData = json.decode(data.body);
      routes = jsonData["results"];
    });
  }

  @override
  void initState() {
    this._getRoutes();
    controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });
    @override
    void dispose() {
      controller.dispose();
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topAppBar,
        body: new Material(
            child: new Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: new TextField(
          decoration: new InputDecoration(labelText: "Search something"),
          controller: controller,
        ),
      ),
      new Expanded(
        child: new ListView.builder(
          itemCount: routes == null ? 0 : routes.length,
          itemBuilder: (BuildContext context, i) {
            return filter == null || filter == ""
                ? new Card(
                    child: new ListTile(
                        title: new Text(routes[i]["route"]),
                        subtitle: new Text(routes[i]["operator"]),
                        leading: new CircleAvatar(
                          backgroundImage: new NetworkImage(
                              'http://seekvectorlogo.com/wp-content/uploads/2018/08/tfi-transport-for-ireland-vector-logo-small.png'),
                        )))
                : routes[i]["route"].toLowerCase().contains(filter)
                    ? new Card(
                        child: new ListTile(
                            title: new Text(routes[i]["route"]),
                            subtitle: new Text(routes[i]["operator"]),
                            leading: new CircleAvatar(
                              backgroundImage: new NetworkImage(
                                  'http://seekvectorlogo.com/wp-content/uploads/2018/08/tfi-transport-for-ireland-vector-logo-small.png'),
                            )))
                    : new Container();
          },
        ),
      ),
    ])));
  }
}
