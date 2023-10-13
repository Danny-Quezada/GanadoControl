import 'package:flutter/material.dart';
import 'package:flutter_provider_utilities/flutter_provider_utilities.dart';
import 'package:hackathon_app/provider/cattle_provider.dart';
import 'package:hackathon_app/ui/pages/mobil/add_cow_page.dart';
import 'package:hackathon_app/ui/widgets/flushbar_widget.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/Entities/cattle.dart';
import '../../config/color_palette.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/custom_card_widget.dart';
import '../../widgets/search_bar.dart';
import 'cow_information_page.dart';

class CowPage extends StatelessWidget {
  int flockId;
  CowPage({super.key, required this.flockId});
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      floatingActionButton: floatingActionButton(farmId: flockId),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: SingleChildScrollView(
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
                  backgroundColor: const Color(0xFFf2f2f2),
                  function: (value) {}),
              SizedBox(
                height: size.height*.8,
                width: size.width,
                child: CattleList(GroupId: flockId),
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
        return CowInformationPage(cattle: ganado);
      },
    ));
  }
}

class CattleList extends StatelessWidget {
  int GroupId;
  CattleList({required this.GroupId});

  @override
  Widget build(BuildContext context) {
    final cattleProvider = Provider.of<CattleProvider>(context, listen: false);
    cattleProvider.getAllCattleByGroup(GroupId);
    return MessageListener<CattleProvider>(
      child: Consumer<CattleProvider>(
          builder: (context, CattleProviderConsumer, child) {
        if (cattleProvider.list == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: CattleProviderConsumer.list!.length,
          itemBuilder: (BuildContext context, int index) {
            return Selector<CattleProvider, Cattle>(
              builder: (context, cattle, child) {
                return CustomCardWidget([
                  cattle.race,
                  (DateTime.now().year - cattle.birthDate.year).toString() +
                      "año"
                ],
                    function: () {},
                    urlImage: cattle.urlImage!,
                    title: cattle.idCattle,
                    description:
                        "Ultima vacuna: \n ultima desparasitacion: 00:00:00 \n Peso: 262kg",
                    radius: 12,
                    onLongPress: () {});
              },
              selector: (p0, p1) => p1.list![index],
            );
          },
        );
      }),
      showInfo: (info) {
        flushbarWidget(context: context, title: "Enhorabuena", message: info);
      },
      showError: (error) {
        flushbarWidget(
            context: context, title: "Error", message: error, error: false);
      },
    );
  }
}

class floatingActionButton extends StatelessWidget {
  int farmId;
  floatingActionButton({required this.farmId});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return AddCowPage(
                      famrId: farmId,
                    );
                  },
                ));
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
