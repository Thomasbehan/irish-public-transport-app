import 'package:flutter/material.dart';
import 'package:irish_public_transport_app/classes/HomeData.dart';
import 'package:irish_public_transport_app/elements/HomeItem.dart';
import 'package:irish_public_transport_app/transformers/HomeTransformers.dart';
import 'Routes.dart';
import 'Stops.dart';
import 'Favourites.dart';
import 'Settings.dart';
import 'package:screen/screen.dart';

class HomePage extends StatelessWidget {
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
    void _goToSettings() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Settings()),
      );
    }

    return Scaffold(
      body: Center(
        child: SizedBox.fromSize(
          size: const Size.fromHeight(500.0),
          child: PageTransformer(
            pageViewBuilder: (context, visibilityResolver) {
              return PageView.builder(
                controller: PageController(viewportFraction: 0.85),
                itemCount: sampleItems.length,
                itemBuilder: (context, index) {
                  final item = sampleItems[index];
                  final pageVisibility =
                      visibilityResolver.resolvePageVisibility(index);

                  return new InkWell(
                      onTap: () {
                        switch(item.category) {
                          case "ROUTES": {
                            _goToRoutes();
                          }
                          break;

                          case "STOPS": {
                            _goToStops();
                          }
                          break;

                          case "FAVOURITES": {
                            _goToFavourites();
                          }
                          break;

                          case "SETTINGS": {
                            _goToSettings();
                          }
                          break;

                          default: {
                            //statements;
                          }
                          break;
                        }
                      },
                      child: IntroPageItem(
                        item: item,
                        pageVisibility: pageVisibility,
                      ));
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
