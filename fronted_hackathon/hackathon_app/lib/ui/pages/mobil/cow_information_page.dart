import 'package:flutter/material.dart';
import 'package:hackathon_app/domain/models/Entities/cattle.dart';
import 'package:hackathon_app/domain/models/enums/pharmaceuticals.dart';
import 'package:hackathon_app/ui/config/color_palette.dart';
import 'package:hackathon_app/ui/widgets/pills_widget.dart';

class CowInformationPage extends StatelessWidget {
  Cattle cow;
  CowInformationPage({super.key, required this.cow});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              color: Colors.grey.shade100,
              width: size.width,
              height: size.height * .3,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                width: size.width,
                height: size.height * .8,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.grey.shade100.withOpacity(0.8),
                        radius: size.width * .2,
                        child: Image.asset("assets/images/sections/image.png"),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Identificador",
                        style: TextStyle(
                            fontFamily: "Karla", fontWeight: FontWeight.bold),
                      ),
                      Text(
                        cow.idCattle.toString(),
                        style: TextStyle(
                            color: ColorPalette.colorFontTextFieldPrincipal,
                            fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const OptionMenu(),
                      const ListMedical()
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ListMedical extends StatelessWidget {
  const ListMedical({
    super.key,
    
  });


  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height * 0.5,
      child: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: PillWidget(2,
                pharmaceuticals: Pharmaceuticals.vaccine,
                title: "Derri A plus",function: (){}),
              
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: PillWidget(2,
                pharmaceuticals: Pharmaceuticals.medications,
                title: "Marbox",function: (){}),
          )
        ],
      ),
    );
  }
}

class OptionMenu extends StatefulWidget {
  const OptionMenu({super.key});

  @override
  State<OptionMenu> createState() => _OptionMenuState();
}

class _OptionMenuState extends State<OptionMenu> {
  String value = "Todo";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(12),
                border: Border.all(color: Colors.grey.shade100, width: 2)),
            child: DropdownButton(
              items: const [
                DropdownMenuItem(
                  child: Text("Todo"),
                  value: "Todo",
                ),
                DropdownMenuItem(
                  child: Text("Medicamentos"),
                  value: "Medicamentos",
                ),
                DropdownMenuItem(
                  child: Text("Vitaminas"),
                  value: "Vitaminas",
                ),
                DropdownMenuItem(child: Text("Vacunas"), value: "Vacunas"),
              ],
              style:
                  TextStyle(color: Colors.grey.shade400, fontFamily: "Karla"),
              underline: Container(),
              value: value,
              elevation: 5,
              onChanged: (valuee) {
                setState(() {
                  value = valuee!;
                });
              },
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: Image.asset("assets/images/icons/calendar.png")),
          IconButton(
              onPressed: () {},
              icon: Image.asset("assets/images/icons/cowFamily.png")),
          IconButton(
              onPressed: () {},
              icon: Image.asset("assets/images/icons/greenPlus.png"))
        ],
      ),
    );
  }
}
