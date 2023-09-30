import 'package:flutter/material.dart';
import 'package:hackathon_app/domain/models/Entities/flock.dart';
import 'package:hackathon_app/provider/farm_provider.dart';
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
  FarmCard(
      {super.key,
      required this.idFarm,
      required this.farmName,
      required this.groups,
      required this.location,
      required this.hectares});

  @override
  Widget build(BuildContext context) {
    final flockProvider=Provider.of<FlockProvider>(context,listen: false);
    Size size = MediaQuery.of(context).size;
    TextStyle style = TextStyle(
        fontFamily: "Karla",
        fontSize: 15,
        color: ColorPalette.colorFontTextFieldPrincipal,
        fontWeight: FontWeight.w400);
    return GestureDetector(
      onTap: (){
        if( (flockProvider.t?.farmId)!=idFarm){
          flockProvider.doNull();
        }
        flockProvider.t=Flock(flockName: "", farmId: idFarm);
        cattlePage(context, idFarm);},
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
    );
  }

  void cattlePage(BuildContext context, int idFarm) {
    //TODO: Tener una propiedad que sea una funcion para diferenciar movil o web
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return CattlePage(farmId: idFarm);
      },
    ));
  }
}
