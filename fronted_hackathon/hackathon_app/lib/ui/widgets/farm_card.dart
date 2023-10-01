import 'package:flutter/material.dart';
import 'package:hackathon_app/domain/models/Entities/flock.dart';
import 'package:hackathon_app/provider/flock_provider.dart';
import 'package:hackathon_app/ui/config/color_palette.dart';
import 'package:hackathon_app/ui/pages/mobil/cattle_page.dart';
import 'package:provider/provider.dart';

class FarmCard extends StatelessWidget {
  int idFarm;
  String farmName;
  int groups;
  String location;
  int hectares;
  bool? isSelected;
  VoidCallback onTap;
  VoidCallback onLongPress;
  FarmCard(
      {super.key,
      required this.idFarm,
      required this.farmName,
      required this.groups,
      required this.location,
      required this.hectares,
      this.isSelected=false,
      required this.onTap,
      required this.onLongPress
 });

  @override
  Widget build(BuildContext context) {
    
    Size size = MediaQuery.of(context).size;
    TextStyle style = TextStyle(
        fontFamily: "Karla",
        fontSize: 15,
        color: ColorPalette.colorFontTextFieldPrincipal,
        fontWeight: FontWeight.w400);
    return GestureDetector(
      onLongPress: onLongPress,
      onTap:   onTap,
      child: Stack(
        children:[ SizedBox(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              farmName,
              style: style,
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              height: size.height * .1,
              width: size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300, width: 2)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("Número de grupos: $groups", style: style),
                  Text(
                    "Ubicación: $location",
                    overflow: TextOverflow.clip,
                    style: style,
                  ),
                  Text(
                    "Hectareas: $hectares",
                    style: style,
                  )
                ],
              ),
            ),
          ]),
        ),
        Visibility(visible: isSelected!,child: Container(height: (size.height*.1)+25, width: size.width,color: Colors.blue.withOpacity(0.1),))
        ]
      ),
    );
  }

  
}
