/**
 * THIS IS AN EXAMPLE PAGE PLEASE DO NOT EDIT OR DELETE
 */

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:irish_public_transport_app/elements/sidemenu.dart';
import 'package:irish_public_transport_app/elements/topBar.dart';
import 'package:irish_public_transport_app/pages/Homev2.dart';
import 'package:toast/toast.dart';
import 'Realtime.dart';

class Favourites extends StatefulWidget {
  Favourites({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  TextEditingController controller = new TextEditingController();
  String filter;
  String title;
  Map<String, String> stops;

  final storage = new FlutterSecureStorage();
  Map<String, String> allValues;

  Future loadFavourites() async {
    Map<String, String> allValues = await storage.readAll();
    if (allValues.isNotEmpty) {
      allValues.removeWhere((k, v) => k.contains("Setting_"));
    }
    setState(() {
      stops = allValues;
    });
  }

  @override
  void initState() {
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

    loadFavourites();
  }

  void _goToRealtime(stopId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Realtime(stopId: stopId)),
    );
  }

  Future removeFavourite(stop) async {
    await storage.delete(key: stop.toString());
    Toast.show(stop.toString() + " Removed From Your Favourites", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  }

  @override
  Widget build(BuildContext context) {
    final topAppBar = topBar.get(context, 'Your Favourites');

    return new WillPopScope(
      child: Scaffold(
          appBar: topAppBar,
          drawer: sidemenu.getMenu(context),
          body: new Material(
              child: new Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new TextField(
                decoration: new InputDecoration(
                    labelText: "Search Your Favourites... "),
                controller: controller,
              ),
            ),
            new Expanded(
              child: new ListView.builder(
                itemCount: stops == null ? 0 : stops.length,
                itemBuilder: (BuildContext context, index) {
                  String i = stops.keys.elementAt(index);
                  return filter == null || filter == ""
                      ? Dismissible(
                          onDismissed: (direction) {
                            removeFavourite(stops[i]);
                          },
                          background: Container(color: Colors.red),
                          key: Key(stops[i]),
                          child: new InkWell(
                              onTap: () {
                                this._goToRealtime(stops[i]);
                              },
                              child: new Card(
                                  child: new ListTile(
                                      title: new Text(stops[i]),
                                      subtitle: new Text(
                                          "Touch to view realtime data"),
                                      leading: new CircleAvatar(
                                          child: new Icon(
                                        Icons.nature_people,
                                        color: Colors.white,
                                        size: 30.0,
                                      ))))))
                      : stops[i].toLowerCase().contains(filter)
                          ? Dismissible(
                              onDismissed: (direction) {
                                removeFavourite(stops[i]);
                              },
                              background: Container(color: Colors.red),
                              key: Key(stops[i]),
                              child: new InkWell(
                                  onTap: () {
                                    this._goToRealtime(stops[i]);
                                  },
                                  child: new Card(
                                      child: new ListTile(
                                          title: new Text(stops[i]),
                                          subtitle: new Text(
                                              "Touch to view realtime data"),
                                          leading: new CircleAvatar(
                                              child: new Icon(
                                            Icons.nature_people,
                                            color: Colors.white,
                                            size: 30.0,
                                          ))))))
                          : new Container();
                },
              ),
            ),
          ]))),
      onWillPop: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      },
    );
  }
}
