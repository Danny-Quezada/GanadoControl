import 'package:flutter/material.dart';
import 'package:hackathon_app/ui/pages/mobil/add_cow_page.dart';


import '../../../domain/models/Entities/cattle.dart';
import '../../config/color_palette.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/custom_card_widget.dart';
import '../../widgets/search_bar.dart';
import 'cow_information_page.dart';

class CowPage extends StatelessWidget {
  int farmId;
  CowPage({super.key, required this.farmId});
  TextEditingController _controller=TextEditingController();

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      floatingActionButton:  floatingActionButton(farmId: farmId),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
               searchBar(controller: _controller,height: 35,padding: 16,iconColor:const Color(0xffABA5A5),backgroundColor: const Color(0xFFf2f2f2)),
              SizedBox(
                width: size.width,
                height: size.height - 35,
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    CustomCardWdiget(
                        function: () =>
                            cowInformationPage(context, Cattle(birthDate: DateTime.now(),groupId: 2,idCattle: "",race: "",type: "",weight: 22,fatherId:"",motherId: "")),
                        const [
                          "Reyna",
                          "4 años",
                        ],
                        urlImage: "",
                        title: "Vaca",
                        description:
                            "Ultima vacuna: 00:00:00 \n ultima desparasitacion: 00:00:00 \n Peso: 262kg",
                        radius: 12)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  void cowInformationPage(BuildContext context, Cattle ganado) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return CowInformationPage(cow: ganado);
      },
    ));
  }
}

class floatingActionButton extends StatelessWidget {

  int farmId;
   floatingActionButton({
    required this.farmId
   
  });



  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ButtonWidget(
              text: "Seleccionar",
              size: Size(size.width / 3.2, 20),
              color: Colors.blue.shade400,
              rounded: 20,
              function: () {},
              fontSize: 14),
          ButtonWidget(
              text: "Crear vaca",
              size: Size(size.width / 3.2, 20),
              color: ColorPalette.colorPrincipal,
              rounded: 20,
              function: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AddCowPage(famrId: farmId,);
                },));
              },
              fontSize: 14),
          ButtonWidget(
              text: "Crear toro",
              size: Size(size.width / 3.2, 20),
              color: ColorPalette.colorPrincipal,
              rounded: 20,
              function: () {},
              fontSize: 14)
        ],
      ),
    );
  }
}
