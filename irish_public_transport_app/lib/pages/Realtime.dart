import 'dart:convert';
import 'package:irish_public_transport_app/elements/sidemenu.dart';
import 'Routes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Realtime extends StatefulWidget {
  Realtime({Key key, @required this.stopId, this.title}) : super(key: key);

  final String stopId;
  final String title;

  @override
  _RealtimeState createState() => _RealtimeState();
}

class _RealtimeState extends State<Realtime> {
  TextEditingController controller = new TextEditingController();
  String filter;

  List realtime = [];

  Future<List> _getRealtime() async {
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
    this._getRealtime();
  }

  @override
  Widget build(BuildContext context) {
    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: Color.fromRGBO(45, 150, 255, 1.0),
      title: Text('Stop No. ' + widget.stopId),
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
        ])));
  }
}
