import 'package:flutter/material.dart';
import 'package:screen/screen.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IPT BETA',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Public Transport App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController controller = new TextEditingController();
  String filter;

  void keepScreenOn() {
    // Prevent screen from going into sleep mode:
    Screen.keepOn(true);
  }

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
    return new Material(
        child: new Column(
            children: <Widget>[
              new Padding(
                padding: new EdgeInsets.only(top: 20.0),
              ),
              new TextField(
                decoration: new InputDecoration(
                    labelText: "Search something"
                ),
                controller: controller,
              ),
              new Expanded(
                child: new ListView.builder(
                  itemCount: routes == null ? 0 : routes.length,
                  itemBuilder: (BuildContext context, i) {
                    return filter == null || filter == "" ? new Card(
                        child: new ListTile(
                            title: new Text(routes[i]["route"]),
                            subtitle: new Text(routes[i]["operator"]),
                            leading: new CircleAvatar(
                              backgroundImage:
                              new NetworkImage(
                                  'http://seekvectorlogo.com/wp-content/uploads/2018/08/tfi-transport-for-ireland-vector-logo-small.png'),
                            )
                        )) : routes[i]["route"].toLowerCase().contains(
                        filter)
                        ? new Card(child: new ListTile(
                        title: new Text(routes[i]["route"]),
                        subtitle: new Text(routes[i]["operator"]),
                        leading: new CircleAvatar(
                          backgroundImage:
                          new NetworkImage(
                              'http://seekvectorlogo.com/wp-content/uploads/2018/08/tfi-transport-for-ireland-vector-logo-small.png'),
                        )
                    ))
                        : new Container();
                  },
                ),
              ),
            ])
    );
  }
