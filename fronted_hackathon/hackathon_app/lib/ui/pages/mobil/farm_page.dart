import 'package:flutter/material.dart';
import 'package:hackathon_app/domain/models/Entities/farm.dart';
import 'package:hackathon_app/provider/farm_provider.dart';
import 'package:hackathon_app/provider/user_provider.dart';
import 'package:hackathon_app/ui/config/color_palette.dart';
import 'package:hackathon_app/ui/pages/mobil/add_farm_page.dart';
import 'package:hackathon_app/ui/widgets/button_widget.dart';
import 'package:hackathon_app/ui/widgets/farm_card.dart';
import 'package:provider/provider.dart';

class FarmPage extends StatelessWidget {
  final Stopwatch _stopwatch=Stopwatch();
  
  FarmPage();

  @override
  Widget build(BuildContext context) {
    final userProvider=Provider.of<UserProvider>(context,listen: false);
    int userId=userProvider.user!.userId!;
    Size size = MediaQuery.of(context).size;
    return Stack(children: [
      Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: farmList(
          userId: userId,
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
              function: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return AddFarmPage(userId: userId);
                  },
                ));
              },
              fontSize: 14))
    ]);
  }
}

class farmList extends StatelessWidget {
   final Stopwatch _stopwatch=Stopwatch();
  int userId;
  farmList({required this.userId});

  @override
  Widget build(BuildContext context) {
    
    final farmProvider = Provider.of<FarmProvider>(context, listen: false);
    return FutureBuilder(
      future: farmProvider.getAllFarmByUserId(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
           
          List<Farm> farms = snapshot.data!;
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return FarmCard(
                  idFarm: farms[index].farmId!,
                  farmName: farms[index].farmName,
                  groups: farms[index].groups!,
                  location: farms[index].location,
                  hectares: farms[index].hectares);
            },
          );
        } else {
          return const Center(
            child: Text("Error en el servicio, intente nuevamente"),
          );
        }
      },
    );
  }
}
