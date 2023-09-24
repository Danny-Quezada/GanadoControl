
import 'package:flutter/material.dart';


class searchBar extends StatelessWidget {
  searchBar({
    required this.iconColor, 
    required this.backgroundColor,
    required this.controller,
    required this.padding,
    required this.height,
    super.key,
  });
  Color iconColor;
  Color backgroundColor;
  TextEditingController controller;
  double padding;
  double height;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: padding, right: padding),  //16
        height: height, //35
        child:  SearchBar(
          elevation: MaterialStatePropertyAll<double?>(0),
          leading: Icon(
            Icons.search,
            color: iconColor,
          ),
          backgroundColor:
             const MaterialStatePropertyAll<Color>(Color(0xFFf2f2f2)),
        ));
  }
}
