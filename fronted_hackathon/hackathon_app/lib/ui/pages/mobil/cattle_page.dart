import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hackathon_app/ui/config/color_palette.dart';
import 'package:hackathon_app/ui/pages/mobil/inventary_page.dart';
import 'package:hackathon_app/ui/util/validator_textfield.dart';
import 'package:hackathon_app/ui/widgets/button_widget.dart';

import '../../widgets/custom_card_widget.dart';
import '../../widgets/custom_form_field.dart';
import '../../widgets/search_bar.dart';
import '../../widgets/select_image_widget.dart';
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
        floatingActionButton: addGroupWidget(
          farmId: farmId,
        ),
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

class addGroupWidget extends StatelessWidget {
  int farmId;
  addGroupWidget({required this.farmId});

  @override
  Widget build(BuildContext context) {
    TextEditingController groupController = TextEditingController();
    FocusNode groupNode = FocusNode();
    return FloatingActionButton.extended(
      elevation: 0,
      backgroundColor: ColorPalette.colorPrincipal,
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  SelectImageWidget(
                      diameter: 180,
                      color: Colors.grey.shade200,
                      onChange: (File file) {}),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomFormField(
                      textEditingController: groupController,
                      validator: ValidatorTextField.genericStringValidator,
                      nextFocusNode: null,
                      focusNode: groupNode,
                      hintText: "Rebaño #3",
                      labelText: "Nombre del grupo",
                      obscureText: false),
                  ButtonWidget(text: "Agregar", size: Size(210, 30), color: ColorPalette.colorPrincipal, rounded: 20, function: (){}, fontSize: 14)
                ],
              ),
            );
          },
        );
      },
      label: const Text(
        "Agregar grupo",
        style: TextStyle(color: Colors.white),
      ),
    );
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
