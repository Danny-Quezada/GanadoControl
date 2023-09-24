import 'package:flutter/material.dart';

import '../../widgets/custom_card_widget.dart';
import '../../widgets/search_bar.dart';
import 'cow_page.dart';

class CastlePage extends StatelessWidget {
  int idFarm;
  CastlePage({super.key, required this.idFarm});
  TextEditingController _controller=TextEditingController(); 
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
              searchBar(controller: _controller,height: 35,padding: 16,iconColor:const Color(0xffABA5A5),backgroundColor: const Color(0xFFf2f2f2)),
              const inventaryButton(),
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
        return CowPage(idCastle: idCastle);
      },
    ));
  }
}

class inventaryButton extends StatelessWidget {
  const inventaryButton({
    super.key,
    
  });

  

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(left: size.width * .05),
      child: TextButton(
          style: const ButtonStyle(
              splashFactory: NoSplash.splashFactory),
          onPressed: () {},
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
                    color: Color(0xFFCA78FF),
                    fontWeight: FontWeight.bold),
              )
            ],
          )),
    );
  }
}
