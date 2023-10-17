import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hackathon_app/domain/models/Entities/cattle.dart';
import 'package:hackathon_app/domain/models/Entities/cow_calving.dart';
import 'package:hackathon_app/domain/models/Entities/insemination.dart';
import 'package:hackathon_app/provider/body_part_provider.dart';
import 'package:hackathon_app/provider/cattle_provider.dart';
import 'package:hackathon_app/provider/cow_calving_provider.dart';
import 'package:hackathon_app/provider/insemination_provider.dart';
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

String? type;

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
  bool status;
  AddCowPage({required this.famrId, required this.status});

  @override
  Widget build(BuildContext context) {
    var cattleProvider = Provider.of<CattleProvider>(context, listen: false);
    final physicalProblemsProvider =
        Provider.of<PhysicalProblemProvider>(context, listen: false);
    final bodyPartProvider =
        Provider.of<BodyPartProvider>(context, listen: false);
    final inseminationProvider =
        Provider.of<InseminationProvider>(context, listen: false);
    final cowCalvingProvider =
        Provider.of<CowCalvingProvider>(context, listen: false);
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
                Visibility(
                  visible: status,
                  child: CustomFormField(
                      textInput: TextInputType.number,
                      textEditingController: cowCalvingController,
                      validator: ValidatorTextField.genericNumberValidator,
                      nextFocusNode: null,
                      focusNode: cowCalvingNode,
                      hintText: "8",
                      labelText: "Número de parto",
                      obscureText: false),
                ),
                DateTimePicker(
                  text: "Fecha de nacimiento",
                  size: const Size(275, 31),
                  dateTimeController: birthDateTimeController,
                  color: ColorPalette.colorFontTextFieldPrincipal,
                ),
                const SizedBox(
                  height: 20,
                ),
                Visibility(
                  visible: status,
                  child: DateTimePicker(
                    text: "Fecha de inseminación",
                    size: const Size(275, 31),
                    dateTimeController: inseminationDateTimeController,
                    color: ColorPalette.colorFontTextFieldPrincipal,
                  ),
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
                      text: status == true ? "Agregar vaca" : "AGregar toro",
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
                            type: "",
                            groupId: famrId,
                            status: "activo",
                          );

                          if (status == true) {
                            cattle.type = "Vaca";
                          } else if (status == false) {
                            cattle.type = "Toro";
                          }

                          File fileImage = file ??
                              await PathImageAsset.getImageFileFromAssets(
                                  "images/sections/image.png");
                          cattle.imageName = fileImage!.path.split("/").last;
                          cattle.imagePath = fileImage.path;
                          await cattleProvider.create(cattle);

                          if (status == true) {
                            CowCalving cowCalving = CowCalving(
                                cattleId: identifierController.text,
                                type: type!,
                                successful: true,
                                date: DateTime.parse(
                                    inseminationDateTimeController.text));
                            cowCalvingProvider.create(cowCalving);
                          }

                          for (int i = 0;
                              i < bodyPartProvider.physicalProblems.length;
                              i++) {
                            bodyPartProvider.physicalProblems[i].cattleId =
                                identifierController.text;
                            await physicalProblemsProvider
                                .create(bodyPartProvider.physicalProblems[i]);
                          }
                          bodyPartProvider.physicalProblems = [];

                          if (status == true) {
                            Insemination insemination = Insemination(
                                IdInsemination: 1,
                                cattleId: identifierController.text,
                                inseminationDate: DateTime.parse(
                                    inseminationDateTimeController.text));
                            await inseminationProvider.create(insemination);
                          }

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
      type = "Natural";
    });
  }

  checkBoxCallbackCesarea(bool checkBoxState) {
    setState(() {
      isCheckedCesarea = checkBoxState;
      isCheckedNatural = !isCheckedCesarea;
      type = "Cesárea";
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
