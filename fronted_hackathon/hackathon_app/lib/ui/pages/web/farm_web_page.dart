import 'package:flutter/material.dart';
import 'package:hackathon_app/ui/widgets/farm_card.dart';
import 'package:hackathon_app/ui/widgets/farm_card_web.dart';

class FarmWebPage extends StatelessWidget {
  FarmWebPage({super.key});

  int noCuadros = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: const Center(
          child: Text(
            'Fincas',
            style: TextStyle(color: Colors.black),
          ),
        ),
        actions: const [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
                'https://upload.wikimedia.org/wikipedia/commons/3/3c/Tom_Holland_by_Gage_Skidmore.jpg'), // Ruta de la imagen
          ),
          SizedBox(width: 20), // Espacio entre la imagen y otros elementos
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.only(left: 16, right: 16),
                height: 35,
                child: const SearchBar(
                  elevation: MaterialStatePropertyAll<double?>(0),
                  leading: Icon(
                    Icons.search,
                    color: Color(0xffABA5A5),
                  ),
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Color(0xFFf2f2f2)),
                )),
            const SizedBox(
              height: 25,
            ),
            buildGrip(),
          ],
        ),
      ),
    );
  }

  Widget buildGrip() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 2.0,
          childAspectRatio: 1.6,
          mainAxisExtent: 185),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: noCuadros,
      itemBuilder: (context, index) {
        int prueba = index + 1;
        return FarmCardWeb(
            idFarm: noCuadros,
            farmName: "Finca" + " $prueba",
            groups: noCuadros,
            location: "Managua-Nicaragua",
            hectares: 24);
      },
    );
  }
}
