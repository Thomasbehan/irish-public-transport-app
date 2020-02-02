import 'package:flutter/material.dart';
import 'package:irish_public_transport_app/pages/Homev2.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:toast/toast.dart';

class topBar {

  static get(context, title) {
    return AppBar(
      elevation: 2.0,
      textTheme: TextTheme(title: TextStyle(color: Colors.black)),
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
      //Color.fromRGBO(45, 150, 255, 1.0),
      title: Text(title),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          },
        )
      ],
    );
  }



  static getWithFav(context, title, stop) {

    final storage = new FlutterSecureStorage();

    Future saveFavourite(stop) async {
      await storage.write(key: stop.toString(), value: stop.toString());
      Toast.show(stop.toString() + " Added To Your Favourites", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
    }


    return AppBar(
      elevation: 2.0,
      textTheme: TextTheme(title: TextStyle(color: Colors.black)),
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
      //Color.fromRGBO(45, 150, 255, 1.0),
      title: Text(title),
      actions: <Widget>[
        IconButton(
          icon: new Icon(Icons.favorite_border),
          onPressed: () {
            saveFavourite(stop);
          },
        ),
        IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          },
        )
      ],
    );
  }

}
