import 'package:flutter/material.dart';
import 'package:hackathon_app/ui/config/color_palette.dart';
import 'package:hackathon_app/ui/pages/web/cow_web_page.dart';
import 'package:hackathon_app/ui/pages/web/group_web_page.dart';

class FarmCardWeb extends StatelessWidget {
  int idFarm;
  String farmName;
  int groups;
  String location;
  double hectares;
  FarmCardWeb(
      {super.key,
      required this.idFarm,
      required this.farmName,
      required this.groups,
      required this.location,
      required this.hectares});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextStyle style = TextStyle(
        fontFamily: "Karla",
        fontSize: 24,
        color: ColorPalette.colorFontTextFieldPrincipal,
        fontWeight: FontWeight.w400);
    return GestureDetector(
      onTap: () => castlePage(context, idFarm),
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            farmName,
            style: style,
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: size.height * 0.2,
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
    );
  }

  void castlePage(BuildContext context, int idFarm) {
    //TODO:HACER REFERENCIA A MI NUEVA PAGINA DE LA WEB
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return const GroupWebPage();
      },
    ));
  }
}
