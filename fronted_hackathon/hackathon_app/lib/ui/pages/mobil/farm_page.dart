import 'package:flutter/material.dart';
import 'package:hackathon_app/ui/config/color_palette.dart';
import 'package:hackathon_app/ui/widgets/button_widget.dart';
import 'package:hackathon_app/ui/widgets/farm_card.dart';

class FarmPage extends StatelessWidget {
  int idUser;
  FarmPage({super.key, required this.idUser});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(children: [
      Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: ListView(
          children: [
            FarmCard(
                idFarm: 2,
                farmName: "Nose",
                groups: 2,
                location: "Managua-Nicaragua",
                hectares: 24)
          ],
        ),
      ),
      Positioned(
          top: size.height - 200,
          left: size.width - 170,
          child: ButtonWidget(
              text: "Agregar finca",
              size: const Size(157, 71),
              color: ColorPalette.colorPrincipal,
              rounded: 23,
              function: () {},
              fontSize: 14))
    ]);
  }
}
