import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Realtime.dart';
import 'package:irish_public_transport_app/elements/topBar.dart';
import 'package:irish_public_transport_app/elements/sidemenu.dart';

class Stops extends StatefulWidget {
  Stops({Key key, this.stops, this.routeId, this.title, this.search}) : super(key: key);

  final List stops;
  final String routeId;
  final String title;
  final String search;

  @override
  _StopsState createState() => _StopsState();
}

class _StopsState extends State<Stops> {
  TextEditingController controller = new TextEditingController();
  String filter;
  String title;
  String search;
  List stops = [];

  Future<List> _getDetails() async {
    var data = await http.get(
        'https://data.smartdublin.ie/cgi-bin/rtpi/busstopinformation?stopid&format=json',
        headers: {"Accept": "application/json"});

    setState(() {
      var jsonData = json.decode(data.body);
      stops = jsonData["results"];
    });
  }

  @override
  void initState() {
    if (widget.stops == null){
      this._getDetails();
    } else {
      stops = widget.stops;
    }
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

  void _goToRealtime(stopId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Realtime(stopId: stopId)),
    );
  }

  @override
  Widget build(BuildContext context) {

    if(widget.search != null){
      controller.text = widget.search;
    }

    title = 'Stops & Terminals';
    if (widget.routeId != null) {
      title = widget.routeId + ' ' + title;
    }

    final topAppBar = topBar.get(context, title);

    return Scaffold(
        appBar: topAppBar,
        drawer: sidemenu.getMenu(context),
        body: new Material(
            child: new Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new TextField(
              decoration: new InputDecoration(
                  labelText: "Search Stops... "),
              controller: controller,
            ),
          ),
          new Expanded(
            child: new ListView.builder(
              itemCount: stops == null ? 0 : stops.length,
              itemBuilder: (BuildContext context, i) {
                return filter == null || filter == ""
                    ? new InkWell(
                        onTap: () {
                          this._goToRealtime(stops[i]["stopid"]);
                        },
                        child: new Card(
                            child: new ListTile(
                                title: new Text(stops[i]["displaystopid"] +
                                    ': ' +
                                    stops[i]["shortname"]),
                                subtitle: new Text("Touch to view realtime data"),
                                leading: new CircleAvatar(
                                    child: new Icon(
                                  Icons.nature_people,
                                  color: Colors.white,
                                  size: 30.0,
                                )))))
                    : stops[i]["displaystopid"].toLowerCase().contains(filter)
                        ? new InkWell(
                            onTap: () {
                              this._goToRealtime(stops[i]["stopid"]);
                            },
                            child: new Card(
                                child: new ListTile(
                                    title: new Text(stops[i]
                                            ["displaystopid"] +
                                        ': ' +
                                        stops[i]["shortname"]),
                                    subtitle: new Text("Touch to view realtime data"),
                                    leading: new CircleAvatar(
                                        child: new Icon(
                                      Icons.nature_people,
                                      color: Colors.white,
                                      size: 30.0,
                                    )))))
                        : new Container();
              },
            ),
          ),
        ])));
  }
}
