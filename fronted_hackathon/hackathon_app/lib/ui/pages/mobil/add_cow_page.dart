import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hackathon_app/domain/models/Entities/cattle.dart';
import 'package:hackathon_app/provider/body_part_provider.dart';
import 'package:hackathon_app/provider/cattle_provider.dart';
import 'package:hackathon_app/provider/physical_problem_provider.dart';
import 'package:hackathon_app/ui/config/color_palette.dart';
import 'package:hackathon_app/ui/pages/mobil/add_detail_physical_page.dart';
import 'package:hackathon_app/ui/util/path_image_asset.dart';
import 'package:hackathon_app/ui/util/validator_textfield.dart';
import 'package:hackathon_app/ui/widgets/button_widget.dart';
import 'package:hackathon_app/ui/widgets/custom_form_field.dart';
import 'package:hackathon_app/ui/widgets/datetime_picker_widget.dart';

import 'package:hackathon_app/ui/widgets/labeled_checkbox.dart';
import 'package:hackathon_app/ui/widgets/select_image_widget.dart';
import 'package:provider/provider.dart';

class AddCowPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController identifierController = TextEditingController();
  TextEditingController raceController = TextEditingController();
  TextEditingController weightContoller = TextEditingController();
  TextEditingController cowCalvingController = TextEditingController();
  TextEditingController birthDateTimeController = TextEditingController();
  TextEditingController inseminationDateTimeController =
      TextEditingController();

  FocusNode identifierNode = FocusNode();
  FocusNode raceNode = FocusNode();
  FocusNode weightNode = FocusNode();
  FocusNode cowCalvingNode = FocusNode();
  File? file;

  int famrId;
  AddCowPage({required this.famrId});

  @override
  Widget build(BuildContext context) {
    var cattleProvider = Provider.of<CattleProvider>(context, listen: false);
    final physicalProblemsProvider =
        Provider.of<PhysicalProblemProvider>(context, listen: false);
    final bodyPartProvider =
        Provider.of<BodyPartProvider>(context, listen: false);
    TextStyle textstyle = TextStyle(
        color: ColorPalette.colorFontTextFieldPrincipal,
        fontWeight: FontWeight.w700);
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(left: 10, top: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SelectImageWidget(
                    diameter: 180,
                    color: Colors.grey.shade200,
                    onChange: (File file) {}),
                const SizedBox(
                  height: 20,
                ),
                CustomFormField(
                    textEditingController: identifierController,
                    validator: ValidatorTextField.genericStringValidator,
                    nextFocusNode: raceNode,
                    focusNode: identifierNode,
                    hintText: "38383-3",
                    labelText: "Identificador",
                    obscureText: false),
                CustomFormField(
                    textEditingController: raceController,
                    validator: ValidatorTextField.genericStringValidator,
                    nextFocusNode: weightNode,
                    focusNode: raceNode,
                    hintText: "Reyna",
                    labelText: "Raza",
                    obscureText: false),
                CustomFormField(
                    textInput: TextInputType.number,
                    textEditingController: weightContoller,
                    validator: ValidatorTextField.genericDecimalValidator,
                    nextFocusNode: cowCalvingNode,
                    focusNode: weightNode,
                    hintText: "220kg",
                    labelText: "Kilos",
                    obscureText: false),
                CustomFormField(
                    textInput: TextInputType.number,
                    textEditingController: cowCalvingController,
                    validator: ValidatorTextField.genericNumberValidator,
                    nextFocusNode: null,
                    focusNode: cowCalvingNode,
                    hintText: "8",
                    labelText: "Número de parto",
                    obscureText: false),
                DateTimePicker(
                  text: "Fecha de nacimiento",
                  size: const Size(275, 31),
                  dateTimeController: birthDateTimeController,
                  color: ColorPalette.colorFontTextFieldPrincipal,
                ),
                const SizedBox(
                  height: 20,
                ),
                DateTimePicker(
                  text: "Fecha de inseminación",
                  size: const Size(275, 31),
                  dateTimeController: inseminationDateTimeController,
                  color: ColorPalette.colorFontTextFieldPrincipal,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Tipo de parto",
                  style: textstyle,
                ),
                CheckboxList(),
                ButtonWidget(
                    text: "Agregar problemas físicos",
                    size: const Size(280, 31),
                    color: ColorPalette.colorFontTextFieldPrincipal,
                    rounded: 16,
                    function: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return AddDetailCowPage(cattleId: '');
                        },
                      ));
                    },
                    fontSize: 16),
                Center(
                  child: ButtonWidget(
                      text: "Agregar vaca",
                      size: const Size(282, 64),
                      color: Colors.green.shade200,
                      rounded: 16,
                      function: () async {
                        final FormState form = _formKey.currentState!;
                        if (form.validate()) {
                          Cattle cattle = Cattle(
                            idCattle: identifierController.text,
                            race: raceController.text,
                            weight: double.parse(weightContoller.text),
                            birthDate:
                                DateTime.parse(birthDateTimeController.text),
                            type: "d",
                            groupId: famrId,
                            status: "activo",
                          );

                          File fileImage = file ??
                              await PathImageAsset.getImageFileFromAssets(
                                  "images/sections/image.png");
                          cattle.imageName = fileImage!.path.split("/").last;
                          cattle.imagePath = fileImage.path;
                          await cattleProvider.create(cattle);

                          for (int i = 0;
                              i < bodyPartProvider.physicalProblems.length;
                              i++) {
                            bodyPartProvider.physicalProblems[i].cattleId =
                                identifierController.text;
                            await physicalProblemsProvider
                                .create(bodyPartProvider.physicalProblems[i]);
                          }
                          bodyPartProvider.physicalProblems = [];

                          Navigator.pop(context);
                        } else {
                          print('Form is invalid');
                        }
                      },
                      fontSize: 16),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CheckboxList extends StatefulWidget {
  const CheckboxList({super.key});

  @override
  State<CheckboxList> createState() => _CheckboxListState();
}

class _CheckboxListState extends State<CheckboxList> {
  bool isCheckedNatural = false;
  bool isCheckedCesarea = false;
  checkBoxCallback(bool checkBoxState) {
    setState(() {
      isCheckedNatural = checkBoxState;
      isCheckedCesarea = !isCheckedNatural;
    });
  }

  checkBoxCallbackCesarea(bool checkBoxState) {
    setState(() {
      isCheckedCesarea = checkBoxState;
      isCheckedNatural = !isCheckedCesarea;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LabeledCheckbox(
          label: "Natural",
          value: isCheckedNatural,
          onChanged: checkBoxCallback,
        ),
        LabeledCheckbox(
            label: "Cesárea",
            value: isCheckedCesarea,
            onChanged: checkBoxCallbackCesarea)
      ],
    );
  }
}
