
import 'package:flutter/material.dart';

class HomepageText {

  static get() {
      return new Text(
        'Hello, How are you?',
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontWeight: FontWeight.bold),
      );
  }

}