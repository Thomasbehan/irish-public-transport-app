
import 'package:flutter/material.dart';
import 'package:irish_public_transport_app/pages/Routes.dart';
import 'package:irish_public_transport_app/pages/Favourites.dart';
import 'package:irish_public_transport_app/pages/Stops.dart';

class sidemenu {
  static getMenu(context){
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('The Irish Public Transport App BETA'),
            decoration: BoxDecoration(
              color: Colors.black,
              image:new DecorationImage(
                  fit: BoxFit.cover,
                  image: new AssetImage('assets/sidemenu.jpg')
              )
            ),
          ),
          ListTile(
            title: Text('Your Favourites'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Favourites()),
              );
            },
          ),
          ListTile(
            title: Text('Routes'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Routes()),
              );
            },
          ),
          ListTile(
            title: Text('Stops'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Stops()),
              );
            },
          ),
        ],
      ),
    );
  }

}