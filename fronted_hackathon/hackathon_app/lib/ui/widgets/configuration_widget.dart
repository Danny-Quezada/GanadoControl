import 'package:flutter/material.dart';
import 'package:touchable/touchable.dart';

class ConfigurationWidget extends StatelessWidget {
  ConfigurationWidget(
      {super.key,
      required this.iconData,
      required this.color,
      required this.text,
      required this.function});
  IconData iconData;
  Color color;
  String text;
  VoidCallback function;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            child: Icon(
              iconData,
              color: Colors.white70,
              size: 32,
            ),
            backgroundColor: color,
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            text,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
          )
        ],
      ),
    );
  }
}
