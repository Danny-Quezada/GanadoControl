import 'package:flutter/material.dart';
import 'package:flutter_provider_utilities/flutter_provider_utilities.dart';
import 'package:hackathon_app/domain/models/Entities/farm.dart';
import 'package:hackathon_app/provider/farm_provider.dart';
import 'package:hackathon_app/provider/flock_provider.dart';

import 'package:hackathon_app/provider/user_provider.dart';
import 'package:hackathon_app/ui/config/color_palette.dart';
import 'package:hackathon_app/ui/pages/mobil/add_farm_page.dart';
import 'package:hackathon_app/ui/pages/mobil/cattle_page.dart';
import 'package:hackathon_app/ui/widgets/button_widget.dart';
import 'package:hackathon_app/ui/widgets/farm_card.dart';
import 'package:hackathon_app/ui/widgets/flushbar_widget.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/Entities/flock.dart';

class FarmPage extends StatelessWidget {
  final Stopwatch _stopwatch = Stopwatch();

  FarmPage();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    int userId = userProvider.user!.userId!;
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
  int userId;
  farmList({required this.userId});

  @override
  Widget build(BuildContext context) {
    final farmProvider = Provider.of<FarmProvider>(context, listen: false);
    final flockProvider = Provider.of<FlockProvider>(context, listen: false);
    farmProvider.getAllFarmByUserId(userId);
    return MessageListener<FarmProvider>(
      showInfo: (info) {
        flushbarWidget(context: context, title: "Enhorabuena", message: info);
      },
      showError: (error) {
        flushbarWidget(
            context: context, title: "Error", message: error, error: false);
      },
      child: Consumer<FarmProvider>(
        builder: (context, farmProviderConsumer, child) {
          if (farmProviderConsumer.list == null) {
            return Container();
          }
          return ListView.builder(
            itemCount: farmProviderConsumer.searchList == null
                ? farmProviderConsumer.list!.length
                : farmProviderConsumer.searchList!.length,
            itemBuilder: (BuildContext context, int index) {
              return Selector<FarmProvider, Farm>(
                  builder: (context, farm, child) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: FarmCard(
                        idFarm: farm.farmId!,
                        farmName: farm.farmName,
                        groups: farm.groups!,
                        location: farm.location,
                        hectares: farm.hectares,
                        isSelected: farm.isSelected!,
                        onTap: farmProviderConsumer.selectedQuantity == 0
                            ? () {
                                if ((flockProvider.t?.farmId) != farm.farmId) {
                                  flockProvider.doNull();
                                }
                                flockProvider.t =
                                    Flock(flockName: "", farmId: farm.farmId!);
                                cattlePage(context, farm.farmId!);
                              }
                            : () {
                                farmProvider.changeSelect(index);
                              },
                        onLongPress: () {
                          farmProvider.changeSelect(index);
                        },
                      ),
                    );
                  },
                  selector: (p0, p1) => p1.searchList == null
                      ? p1.list![index]
                      : p1.searchList![index]);
            },
          );
        },
      ),
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
