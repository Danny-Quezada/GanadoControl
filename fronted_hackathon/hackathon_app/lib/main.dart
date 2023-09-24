import 'package:flutter/material.dart';
import 'package:hackathon_app/ui/config/color_palette.dart';

import 'ui/pages/mobil/initial_page.dart';


void main(List<String> args) {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: "/",
    routes: {"/": (_) => const InitialPage()},
    theme: ThemeData(
      primaryColor: ColorPalette.colorPrincipal,
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.light(primary: ColorPalette.colorPrincipal),
      fontFamily: "Montserrat",
    ),
  ));
}
