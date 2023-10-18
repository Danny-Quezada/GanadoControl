import 'dart:io';
import 'package:hackathon_app/ui/util/path_image_asset.dart';

import 'package:flutter/material.dart';
import 'package:hackathon_app/domain/models/Entities/farm.dart';
import 'package:hackathon_app/provider/farm_provider.dart';

import 'package:provider/provider.dart';

import '../../config/color_palette.dart';
import '../../util/validator_textfield.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/custom_form_field.dart';
import '../../widgets/datetime_picker_widget.dart';
import '../../widgets/select_image_widget.dart';

class AddFarmPage extends StatelessWidget {
  int userId;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController farmNameController = TextEditingController();
  TextEditingController ownerNameController = TextEditingController();
  TextEditingController hectaresController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  TextEditingController dateTimeController = TextEditingController();

  FocusNode farmNode = FocusNode();
  FocusNode ownerNode = FocusNode();
  FocusNode hectaresNode = FocusNode();
  FocusNode locationNode = FocusNode();
  DateTime initialDate = DateTime.now();
  AddFarmPage({required this.userId});
  File? file;
  @override
  Widget build(BuildContext context) {
    var farmProvider = Provider.of<FarmProvider>(context, listen: false);
    TextStyle textstyle = TextStyle(
        color: ColorPalette.colorFontTextFieldPrincipal,
        fontWeight: FontWeight.w700);
    return SafeArea(
        child: Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectImageWidget(
                  diameter: 180,
                  color: Colors.grey.shade200,
                  onChange: (File fileU) {
                    file = fileU;
                  }),
              const SizedBox(
                height: 25,
              ),
              CustomFormField(
                  textEditingController: farmNameController,
                  validator: ValidatorTextField.genericStringValidator,
                  nextFocusNode: ownerNode,
                  focusNode: farmNode,
                  hintText: "Finca ejemplo",
                  labelText: "Nombre de la finca",
                  obscureText: false),
              CustomFormField(
                  textEditingController: ownerNameController,
                  validator: ValidatorTextField.genericStringValidator,
                  nextFocusNode: hectaresNode,
                  focusNode: ownerNode,
                  hintText: "Ejemplo",
                  labelText: "Nombre del dueño",
                  obscureText: false),
              CustomFormField(
                  textInput: TextInputType.number,
                  textEditingController: hectaresController,
                  validator: ValidatorTextField.genericDecimalValidator,
                  nextFocusNode: locationNode,
                  focusNode: hectaresNode,
                  hintText: "2 hectáreas",
                  labelText: "Hectáreas",
                  obscureText: false),
              CustomFormField(
                  textEditingController: locationController,
                  validator: ValidatorTextField.genericStringValidator,
                  nextFocusNode: null,
                  focusNode: locationNode,
                  hintText: "",
                  labelText: "Ubicación",
                  obscureText: false),
              const SizedBox(
                height: 20,
              ),
              DateTimePicker(
                  color: Colors.grey.shade400,
                  size: const Size(269, 36),
                  dateTimeController: dateTimeController),
              const SizedBox(
                height: 35,
              ),
              Center(
                  child: ButtonWidget(
                      text: "Agregar",
                      size: const Size(228, 61),
                      color: ColorPalette.colorPrincipal,
                      rounded: 25,
                      function: () async {
                        final FormState form = _formKey.currentState!;
                        if (form.validate()) {
                          Farm farm = Farm(
                            userRole: "Creador",
                            farmName: farmNameController.text,
                            location: locationController.text,
                            hectares: int.parse(hectaresController.text),
                            farmOwner: ownerNameController.text,
                          );
                          File fileImage = file ??
                              await PathImageAsset.getImageFileFromAssets(
                                  "images/sections/image.png");
                          farm.imageName = fileImage!.path.split("/").last;
                          farm.imagePath = fileImage.path;
                          farm.creation = DateTime.tryParse(
                              dateTimeController.text == ""
                                  ? DateTime.now().toString()
                                  : dateTimeController.text);
                          
                          farm.userId = userId;
                          await farmProvider.create(farm);
                          Navigator.pop(context);
                        } else {
                          print('Form is invalid');
                        }
                      },
                      fontSize: 16))
            ],
          ),
        ),
      ),
    ));
  }
}
