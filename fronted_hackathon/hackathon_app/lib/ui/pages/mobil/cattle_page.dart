import 'package:flutter/material.dart';
import 'package:hackathon_app/ui/pages/mobil/inventary_page.dart';

import '../../widgets/custom_card_widget.dart';
import '../../widgets/search_bar.dart';
import 'cow_page.dart';

class CattlePage extends StatelessWidget {
  int farmId;
  CattlePage({super.key, required this.farmId});
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              searchBar(
                  controller: _controller,
                  height: 35,
                  padding: 16,
                  iconColor: const Color(0xffABA5A5),
                  backgroundColor: const Color(0xFFf2f2f2)),
              inventaryButton(farmId: farmId),
              CustomCardWdiget(null,
                  function: () => cowPage(context, 2),
                  urlImage: "",
                  title: "Grupo 1",
                  description: "Numero de vacas 2",
                  radius: 12)
            ],
          ),
        ),
      ),
    );
  }

  void cowPage(BuildContext context, int idCastle) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return CowPage(farmId: idCastle);
      },
    ));
  }
}

class inventaryButton extends StatelessWidget {
  int farmId;
  inventaryButton({required this.farmId});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(left: size.width * .05),
      child: TextButton(
          style: const ButtonStyle(splashFactory: NoSplash.splashFactory),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return InventaryPage(farmId: farmId);
              },
            ));
          },
          child: Row(
            children: [
              Image.asset(
                "assets/images/icons/inventory.png",
                width: 36,
                height: 36,
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                "Inventario",
                style: TextStyle(
                    color: Color(0xFFCA78FF), fontWeight: FontWeight.bold),
              )
            ],
          )),
    );
  }
}
