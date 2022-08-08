import 'package:flutter/material.dart';

class MyTheme {
  static get theme {
    return ThemeData(
      // definição da cor primária (primarySwatch) e secundária (secundary))
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple).copyWith(secondary: Colors.deepOrange),
      // fonte principal
      fontFamily: 'Lato',
    );
  }
}
