

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hackathon_app/ui/config/color_palette.dart';
import 'package:hackathon_app/ui/util/validator_textfield.dart';
import 'package:hackathon_app/ui/widgets/button_widget.dart';
import 'package:hackathon_app/ui/widgets/custom_form_field.dart';
import 'package:hackathon_app/ui/widgets/datetime_picker_widget.dart';

import 'package:hackathon_app/ui/widgets/labeled_checkbox.dart';
import 'package:hackathon_app/ui/widgets/select_image_widget.dart';

class AddCowPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController identifierController = TextEditingController();
  TextEditingController raceController = TextEditingController();
  TextEditingController weightContoller = TextEditingController();
  TextEditingController cowCalvingController = TextEditingController();

  FocusNode identifierNode = FocusNode();
  FocusNode raceNode = FocusNode();
  FocusNode weightNode = FocusNode();
  FocusNode cowCalvingNode = FocusNode();
  DateTime birthDate = DateTime.now();
  DateTime inseminationDate = DateTime.now();
  int famrId;
  AddCowPage({required this.famrId});

  @override
  Widget build(BuildContext context) {
    TextStyle textstyle=TextStyle(color: ColorPalette.colorFontTextFieldPrincipal,fontWeight: FontWeight.w700);
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
               SelectImageWidget(diameter: 180, color: Colors.grey.shade200, onChange: (File file){}),
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
                Text(
                    "fecha: ${birthDate.day}/${birthDate.month}/${birthDate.year}",style: textstyle,),
                const SizedBox(height: 8,),
                  DateTimePicker(text: "Fecha de nacimiento", size: const Size(275,31), date: birthDate,color: ColorPalette.colorFontTextFieldPrincipal,),
                const SizedBox(
                  height: 20,
                ),
                 Text(
                    "fecha: ${inseminationDate.day}/${inseminationDate.month}/${inseminationDate.year}",style: textstyle,),
              const SizedBox(height: 8,),
                  DateTimePicker(text: "Fecha de inseminación", size: const Size(275,31), date: inseminationDate,color: ColorPalette.colorFontTextFieldPrincipal,),
               
                  
                const SizedBox(
                  height: 20,
                ),
                 Text("Tipo de parto",style: textstyle,),
                CheckboxList(),
              
                Center(
                  child: ButtonWidget(
                      text: "Agregar vaca",
                      size:const Size(282, 64),
                      color: Colors.green.shade200,
                      rounded: 16,
                      function: () {
                        final FormState form = _formKey.currentState!;
                        if (form.validate()) {
                          print('Form is valid');
                        } else {
                          print('Form is invalid');
                        }
                      },
                      fontSize: 16),
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
  bool isCheckedCesarea=false;
checkBoxCallback(bool checkBoxState) {
    setState(() {
      isCheckedNatural = checkBoxState;
      isCheckedCesarea=!isCheckedNatural;
      });
    
 }
 checkBoxCallbackCesarea(bool checkBoxState) {
    setState(() {
      isCheckedCesarea= checkBoxState;
      isCheckedNatural=!isCheckedCesarea;
      }); 
 }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LabeledCheckbox(label: "Natural",value: isCheckedNatural,onChanged: checkBoxCallback
          ,),
          LabeledCheckbox(label: "Cesárea", value: isCheckedCesarea, onChanged: checkBoxCallbackCesarea)
      ],
    );
  }
}