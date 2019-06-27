import 'dart:convert';
import 'Stops.dart';
import 'Routes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:irish_public_transport_app/elements/sidemenu.dart';

class RouteDetails extends StatefulWidget {
  RouteDetails(
      {Key key, @required this.operator, @required this.route, this.title})
      : super(key: key);

  final String operator;
  final String route;
  final String title;

  @override
  _RouteDetailsState createState() => _RouteDetailsState();
}

class _RouteDetailsState extends State<RouteDetails> {
  TextEditingController controller = new TextEditingController();
  String filter;

  List details = [];

  Future<List> _getDetails() async {
    var data = await http.get(
        'https://data.smartdublin.ie/cgi-bin/rtpi/routeinformation?routeid=' +
            widget.route +
            '&operator=' +
            widget.operator +
            '&format=json',
        headers: {"Accept": "application/json"});

    setState(() {
      var jsonData = json.decode(data.body);
      details = jsonData["results"];
    });
  }

  @override
  void initState() {
    this._getDetails();
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

  void _goToStops(List stopsList){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Stops(stops: stopsList, routeId: widget.route)),
    );
  }
  @override
  Widget build(BuildContext context) {
    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: Color.fromRGBO(45, 150, 255, 1.0),
      title: Text('Route No. ' + widget.route),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new TextField(
              decoration: new InputDecoration(
                  labelText: "Search by destination name... "),
              controller: controller,
            ),
          ),
          new Expanded(
            child: new ListView.builder(
              itemCount: details == null ? 0 : details.length,
              itemBuilder: (BuildContext context, i) {
                return filter == null || filter == ""
                    ? new InkWell(
                        onTap: () {
                          this._goToStops(details[i]["stops"]);
                        },
                        child: new Card(
                            child: new ListTile(
                                title: new Text(details[i]["origin"] +
                                    ' > ' +
                                    details[i]["destination"]),
                                subtitle: new Text("Touch to view stops"),
                                leading: new CircleAvatar(
                                    child: new Icon(
                                  Icons.directions,
                                  color: Colors.white,
                                  size: 30.0,
                                )))))
                    : details[i]["destination"].toLowerCase().contains(filter)
                        ? new InkWell(
                            onTap: () {
                              this._goToStops(details[i]["stops"]);
                            },
                            child: new Card(
                                child: new ListTile(
                                    title: new Text(details[i]["origin"] +
                                        ' > ' +
                                        details[i]["destination"]),
                                    subtitle: new Text("Touch to view stops"),
                                    leading: new CircleAvatar(
                                        child: new Icon(
                                      Icons.directions,
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
