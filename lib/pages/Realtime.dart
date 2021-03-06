import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:irish_public_transport_app/elements/sidemenu.dart';
import 'package:irish_public_transport_app/elements/topBar.dart';

class Realtime extends StatefulWidget {
  Realtime({Key key, @required this.stopId, this.title}) : super(key: key);

  final String stopId;
  final String title;

  @override
  _RealtimeState createState() => _RealtimeState();
}

class _RealtimeState extends State<Realtime>
    with SingleTickerProviderStateMixin{
  TextEditingController controller = new TextEditingController();
  String filter;
  Timer timer;
  AnimationController rotationController;

  List realtime = [];

  final storage = new FlutterSecureStorage();
  bool autoRefresh = false;

  Future loadSettings() async {
    String value = await storage.read(key: "Setting_AutoRefresh");
    autoRefresh = value == "true";
    if (autoRefresh) {
      timer = new Timer.periodic(
          Duration(seconds: 15), (Timer t) => _getRealtime());
    }
    setState(() {
      autoRefresh = value == "true";
    });
  }

  Future<List> _getRealtime() async {
    rotationController.forward(from: 0.0);
    var data = await http.get(
        'https://data.smartdublin.ie/cgi-bin/rtpi/realtimebusinformation?stopid=' +
            widget.stopId +
            '&format=json',
        headers: {"Accept": "application/json"});
    setState(() {
      var jsonData = json.decode(data.body);
      realtime = jsonData["results"];
    });
  }

  @override
  void initState() {
    rotationController = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    this._getRealtime();
    this.loadSettings();
    super.initState();
  }

  void dispose() {
    rotationController.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topAppBar =
        topBar.getWithFav(context, 'Stop No. ' + widget.stopId, widget.stopId);

    return Scaffold(
      appBar: topAppBar,
      drawer: sidemenu.getMenu(context),
      body: new Material(
          child: new Column(children: <Widget>[
        new Expanded(
          child: new ListView.builder(
            itemCount: realtime == null ? 0 : realtime.length,
            itemBuilder: (BuildContext context, i) {
              return new Card(
                  child: new ListTile(
                      title: new Text(realtime[i]["route"] +
                          ': ' +
                          realtime[i]["destination"]),
                      subtitle: new Text(
                          "Due in " + realtime[i]["duetime"] + " Mins"),
                      leading: new CircleAvatar(
                          child: new Text(realtime[i]["duetime"]))));
            },
          ),
        ),
      ])),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          this._getRealtime();
        },
        child: RotationTransition(
          turns: Tween(begin: 0.0, end: 1.0).animate(rotationController),
          child: Icon(Icons.refresh)
        ),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
