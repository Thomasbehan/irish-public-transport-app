import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:irish_public_transport_app/elements/topBar.dart';

import 'RouteDetails.dart';

class Routes extends StatefulWidget {
  Routes({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RoutesState createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  TextEditingController controller = new TextEditingController();
  String filter;

  List routes = [];

  Future<List> _getRoutes() async {
    var data = await http.get(
        'https://data.smartdublin.ie/cgi-bin/rtpi/routelistinformation?format=json',
        headers: {"Accept": "application/json"});

    setState(() {
      var jsonData = json.decode(data.body);
      routes = jsonData["results"];
    });
  }

  @override
  void initState() {
    this._getRoutes();
    controller.addListener(() {
      setState(() {
        filter = controller.text.toLowerCase();
      });
    });
    @override
    void dispose() {
      controller.dispose();
      super.dispose();
    }
  }

  void _goToDetails(operator, routeId) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              RouteDetails(operator: operator, route: routeId)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final topAppBar = topBar.get(context, 'IPT BETA');

    return Scaffold(
        appBar: topAppBar,
        body: new Material(
            child: new Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new TextField(
              decoration: new InputDecoration(labelText: "Search... "),
              controller: controller,
            ),
          ),
          new Expanded(
            child: new ListView.builder(
              itemCount: routes == null ? 0 : routes.length,
              itemBuilder: (BuildContext context, i) {
                return filter == null || filter == ""
                    ? new InkWell(
                        onTap: () {
                          this._goToDetails(
                              routes[i]["operator"], routes[i]["route"]);
                        },
                        child: new Card(
                            child: new ListTile(
                                title: new Text(routes[i]["operator"]),
                                subtitle: new Text("Touch for more info"),
                                leading: new CircleAvatar(
                                    child: new Text(routes[i]["route"])))))
                    : routes[i]["route"].toLowerCase().contains(filter)
                        ? new InkWell(
                            onTap: () {
                              this._goToDetails(
                                  routes[i]["operator"], routes[i]["route"]);
                            },
                            child: new Card(
                                child: new ListTile(
                                    title: new Text(routes[i]["operator"]),
                                    subtitle: new Text("Touch for more info"),
                                    leading: new CircleAvatar(
                                        child: new Text(routes[i]["route"])))))
                        : new Container();
              },
            ),
          ),
        ])));
  }
}
