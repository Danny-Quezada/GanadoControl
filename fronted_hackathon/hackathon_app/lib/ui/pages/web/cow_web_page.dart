import 'package:flutter/material.dart';
import 'package:hackathon_app/domain/models/Entities/cattle.dart';
import 'package:hackathon_app/ui/config/color_palette.dart';
import 'package:hackathon_app/ui/pages/web/group_web_page.dart';
import 'package:hackathon_app/ui/widgets/button_widget.dart';
import 'package:hackathon_app/ui/widgets/custom_card_widget.dart';

class CowWebPage extends StatelessWidget {
  int idCastle;
  CowWebPage({super.key, required this.idCastle});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: const Center(
          child: Text(
            'Ganado',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
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
                height: 15,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ButtonWidget(
                        text: "Seleccionar",
                        size: Size((size.width / 2.8) / 3, 15),
                        color: Colors.blue.shade400,
                        rounded: 20,
                        function: () {},
                        fontSize: 14),
                    const SizedBox(
                      width: 6,
                    ),
                    ButtonWidget(
                        text: "Crear vaca",
                        size: Size((size.width / 2.8) / 3, 15),
                        color: ColorPalette.colorPrincipal,
                        rounded: 20,
                        function: () {},
                        fontSize: 14),
                    const SizedBox(
                      width: 6,
                    ),
                    ButtonWidget(
                        text: "Crear toro",
                        size: Size((size.width / 2.8) / 3, 15),
                        color: ColorPalette.colorPrincipal,
                        rounded: 20,
                        function: () {},
                        fontSize: 14)
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              buildGrip(),
            ],
          ),
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
          mainAxisExtent: 130),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CustomCardWidget(const [
              "Reyna",
              "4 años",
            ],
                onLongPress: () {},
                function: () => cowInformationPage(
                    context,
                    Cattle(
                      idCattle: index.toString(),
                      race: '',
                      weight: 10,
                      birthDate: DateTime.now(),
                      type: '',
                      groupId: index,
                    )),
                urlImage: '',
                title: 'Vaca',
                description:
                    "Ultima vacuna: 00:00:00 \n ultima desparasitacion: 00:00:00 \n Peso: 262kg",
                radius: 12));
      },
    );
  }

  void cowInformationPage(BuildContext context, Cattle cow) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        //TODO: Crear page para la informacion de la vaca y mandarlo para alla
        return const GroupWebPage();
      },
    ));
  }
}
