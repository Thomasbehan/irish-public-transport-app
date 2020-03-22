/**
 * THIS IS AN EXAMPLE PAGE PLEASE DO NOT EDIT OR DELETE
 */

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:irish_public_transport_app/util/favourites.dart';
import 'package:irish_public_transport_app/util/pages.dart';
import 'package:screen/screen.dart';
import 'Favourites.dart';
import 'Routes.dart';
import 'Settings.dart';
import 'Stops.dart';
import 'Realtime.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchControl = new TextEditingController();


  final storage = new FlutterSecureStorage();
  Map<String, String> allValues;
  var list = [];
  Future loadFavourites() async {
    Map<String, String> allValues = await storage.readAll();
    if (allValues.isNotEmpty) {
      allValues.removeWhere((k, v) => k.contains("Setting_"));
      favourites = [];
    }
    allValues.forEach((k, v) => favourites.add({"stop": v, "name": "Stop No: " + v, "action": "Click to view favourite"}));
    print(favourites);
    setState(() {

    });
  }


  void _goToRealtime(stopId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Realtime(stopId: stopId)),
    );
  }

  @override
  void initState() {
    loadFavourites();
  }

  @override
  Widget build(BuildContext context) {

    void _goToFavourites() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Favourites()),
      );
    }

    void _goToRoutes() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Routes()),
      );
    }

    // Prevent screen from going into sleep mode:
    Screen.keepOn(true);
    void _goToStops() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Stops()),
      );
    }

    void _searchStops(textToSearch) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Stops(search: textToSearch)),
      );
    }

    void _goToSettings() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Settings()),
      );
    }

    return Scaffold(

      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "Where are you \ngoing?",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),


          Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey[50],
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              child: TextField(
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.blueGrey[300],
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(color: Colors.white,),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white,),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: "Stop Number(Example 1234):",
                  prefixIcon: Icon(
                    Icons.directions_bus,
                    color: Colors.blueGrey[300],
                  ),
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    color: Colors.blueGrey[300],
                  ),
                ),
                maxLines: 1,
                controller: _searchControl,
                onSubmitted: _searchStops,
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.only(top: 10, left: 20),
            height: 250,
//            color: Colors.red,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              primary: false,
              itemCount: pages == null ? 0 : pages.length,
              itemBuilder: (BuildContext context, int index) {

                Map page = pages.reversed.toList()[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: InkWell(
                    child: Container(
                      height: 250,
                      width: 140,
//                      color: Colors.green,
                      child: Column(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              "${page["img"]}",
                              height: 178,
                              width: 140,
                              fit: BoxFit.cover,
                            ),
                          ),

                          SizedBox(height: 7),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "${page["name"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                              maxLines: 2,
                              textAlign: TextAlign.left,
                            ),
                          ),

                          SizedBox(height: 3),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "${page["description"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.blueGrey[300],
                              ),
                              maxLines: 1,
                              textAlign: TextAlign.left,
                            ),
                          ),

                        ],
                      ),
                    ),
                    onTap: (){
                      switch(index) {
                        case 0: {
                          _goToRoutes();
                        }
                        break;

                        case 1: {
                          _goToStops();
                        }
                        break;

                        case 2: {
                          _goToFavourites();
                        }
                        break;

                        case 3: {
                          _goToSettings();
                        }
                        break;

                        default: {
                          //statements;
                        }
                        break;
                      }
                    },
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: EdgeInsets.all(20),
            child: ListView.builder(
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: favourites == null ? 0 : favourites.length,
              itemBuilder: (BuildContext context, int index) {
                Map page = favourites[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom:15.0),
                  child: InkWell(
                    child: Container(
                      height: 70,
//                ++++++++    color: Colors.red,
                      child: Row(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset(
                              "assets/stops.jpg",
                              height: 70,
                              width: 70,
                              fit: BoxFit.cover,
                            ),
                          ),

                          SizedBox(width: 15),

                          Container(
                            height: 80,
                            width: MediaQuery.of(context).size.width-130,
                            child: ListView(
                              primary: false,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "${page['name']}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                    maxLines: 2,
                                    textAlign: TextAlign.left,
                                  ),
                                ),

                                SizedBox(height: 3),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.location_on,
                                      size: 13,
                                      color: Colors.blueGrey[300],
                                    ),

                                    SizedBox(width: 3),

                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "${page['action']}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          color: Colors.blueGrey[300],
                                        ),
                                        maxLines: 1,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 10),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    maxLines: 1,
                                    textAlign: TextAlign.left,
                                  ),
                                ),


                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                    onTap: (){
                      if (favourites[index]["stop"] != null){
                        this._goToRealtime(favourites[index]["stop"]);
                      }
                    },
                  ),
                );
              },
            ),
          ),


        ],
      ),

    );
  }
}

