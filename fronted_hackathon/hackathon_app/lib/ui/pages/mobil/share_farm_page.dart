import 'package:flutter/material.dart';

class ShareFarmPage extends StatelessWidget {
  int FarmId;
  ShareFarmPage({required this.FarmId});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "Compartir finca",
          style: TextStyle(color: Colors.black),
          
        ),
      ),
    ));
  }
}
