import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hackathon_app/domain/models/Entities/meditation.dart';
import 'package:hackathon_app/domain/models/enums/measurementUnit.dart';
import 'package:hackathon_app/domain/models/enums/pharmaceuticals.dart';
import 'package:hackathon_app/provider/meditation_provider.dart';

import 'package:hackathon_app/ui/util/path_image_asset.dart';
import 'package:hackathon_app/ui/widgets/button_widget.dart';

import 'package:counter/counter.dart';
import 'package:provider/provider.dart';
import '../../config/color_palette.dart';
import '../../util/validator_textfield.dart';
import '../../widgets/custom_form_field.dart';
import '../../widgets/datetime_picker_widget.dart';
import '../../widgets/select_image_widget.dart';

class AddPharmaceuticalPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController meditationNameController = TextEditingController();
  TextEditingController providerNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController deliveryDateTimeController = TextEditingController();
  TextEditingController expirationDateTimeController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController meditationTypeController = TextEditingController();
  TextEditingController measurentUnitController = TextEditingController();
  File? file;
  FocusNode meditationNode = FocusNode();
  FocusNode providerNameNode = FocusNode();
  FocusNode priceNode = FocusNode();
  FocusNode measurentUnitNode = FocusNode();
  FocusNode dropDownFocus = FocusNode();
  int farmId;
  AddPharmaceuticalPage({required this.farmId});

  @override
  Widget build(BuildContext context) {
    final meditationProvider=Provider.of<MeditationProvider>(context);
    TextStyle textstyle = TextStyle(
        color: ColorPalette.colorFontTextFieldPrincipal,
        fontWeight: FontWeight.w700);
    return SafeArea(
        child: Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
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
                height: 60,
              ),
              Text(
                "Tipo",
                style: textstyle,
              ),
              DropDownPharmaceuticalButton(
                drowDownFocus: dropDownFocus,
                meditationController: meditationTypeController,
              ),
              const SizedBox(
                height: 35,
              ),
              Text(
                "Unidad de medida",
                style: textstyle,
              ),
              DropDownMeasurementUnitButton(
                  measurentUnitController: measurentUnitController,
                  drowDownFocus: dropDownFocus),
              const SizedBox(
                height: 25,
              ),
              CustomFormField(
                  textEditingController: meditationNameController,
                  validator: ValidatorTextField.genericStringValidator,
                  nextFocusNode: providerNameNode,
                  focusNode: meditationNode,
                  hintText: "Derri A plus",
                  labelText: "Nombre del medicamento",
                  obscureText: false),
              const SizedBox(
                height: 10,
              ),
              CustomFormField(
                  textEditingController: providerNameController,
                  validator: ValidatorTextField.genericStringValidator,
                  nextFocusNode: priceNode,
                  focusNode: providerNameNode,
                  hintText: "S.A. Ejemplo",
                  labelText: "Nombre del proveedor",
                  obscureText: false),
              const SizedBox(
                height: 10,
              ),
              CustomFormField(
                  textInput: TextInputType.number,
                  textEditingController: priceController,
                  validator: ValidatorTextField.genericDecimalValidator,
                  nextFocusNode: null,
                  focusNode: priceNode,
                  hintText: r"C$500",
                  labelText: "Precio",
                  obscureText: false),
              const SizedBox(height: 25),
              Text(
                "Fecha de caducidad",
                style: textstyle,
              ),
              DateTimePicker(
                size: const Size(275, 31),
                dateTimeController: deliveryDateTimeController,
                color: ColorPalette.colorFontTextFieldPrincipal,
              ),
              const SizedBox(
                height: 35,
              ),
              Text(
                "Fecha de entrega",
                style: textstyle,
              ),
              DateTimePicker(
                size: const Size(275, 31),
                dateTimeController: expirationDateTimeController,
                color: ColorPalette.colorFontTextFieldPrincipal,
              ),
              const SizedBox(
                height: 40,
              ),
              counterWidget(text: "Cantidad", quantity: quantityController),
              const SizedBox(
                height: 40,
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
                          File fileImage = file ??
                              await PathImageAsset.getImageFileFromAssets(
                                  "images/sections/image.png");
                          Meditation meditation = Meditation(
                              meditationName: meditationNameController.text,
                              provider: providerNameController.text,
                              type: meditationTypeController.text,
                              measurementUnit: measurentUnitController.text,
                              expirationDate: DateTime.tryParse(
                                      expirationDateTimeController.text) ??
                                  DateTime.now(),
                              deliveryDate: DateTime.tryParse(
                                      deliveryDateTimeController.text) ??
                                  DateTime.now(),
                              price: priceController.text,
                              quantity:
                                  int.tryParse(quantityController.text) ?? 1,
                              farmId: farmId);
                          meditation.imageName = fileImage!.path.split("/").last;
                          meditation.imagePath = fileImage.path;
                            await meditationProvider.create(meditation);
                          Navigator.pop(context);
                        } else {
                          print('Form is invalid');
                        }
                      },
                      fontSize: 16)),
            ],
          ),
        ),
      ),
    ));
  }
}

class DropDownPharmaceuticalButton extends StatelessWidget {
  TextEditingController meditationController;
  FocusNode drowDownFocus;
  DropDownPharmaceuticalButton(
      {required this.drowDownFocus, required this.meditationController});

  @override
  Widget build(BuildContext context) {
    meditationController.text="Medicamentos";
    return DropdownButtonFormField(
      style: TextStyle(
          color: ColorPalette.colorFontTextFieldPrincipal, fontSize: 16),
      items: Pharmaceuticals.values.map((e) {
        return DropdownMenuItem<Pharmaceuticals>(value: e, child: Text(e.name));
      }).toList(),
      onChanged: (value) {
        meditationController.text = value.toString().replaceAll("Pharmaceuticals.", "");
      },
      focusNode: drowDownFocus,
      value: Pharmaceuticals.Medicamentos,
    );
  }
}

class DropDownMeasurementUnitButton extends StatelessWidget {
  TextEditingController measurentUnitController;
  FocusNode drowDownFocus;
  DropDownMeasurementUnitButton(
      {required this.measurentUnitController, required this.drowDownFocus});
  @override
  Widget build(BuildContext context) {
    measurentUnitController.text="Miligramos";
    return DropdownButtonFormField(
      style: TextStyle(
          color: ColorPalette.colorFontTextFieldPrincipal, fontSize: 16),
      items: measurentUnit.values.map((e) {
        return DropdownMenuItem<measurentUnit>(value: e, child: Text(e.name));
      }).toList(),
      onChanged: (value) {
        measurentUnitController.text = value.toString().replaceAll("measurentUnit.", "");
      },
      focusNode: drowDownFocus,
      value: measurentUnit.Miligramos,
    );
  }
}

class counterWidget extends StatelessWidget {
  TextEditingController quantity;
  String text;
  counterWidget({required this.text, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(
        text,
        style: TextStyle(color: ColorPalette.colorFontTextFieldPrincipal),
      ),
      Counter(
        min: 1,
        max: double.infinity,
        onValueChanged: (value) {
          quantity.text = value.toString();
        },
      )
    ]);
  }
}
