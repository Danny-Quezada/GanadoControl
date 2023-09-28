import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hackathon_app/ui/widgets/button_widget.dart';
import 'package:intl/intl.dart';
import 'package:counter/counter.dart';
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


  FocusNode meditationNode = FocusNode();
  FocusNode providerNameNode = FocusNode();
  FocusNode priceNode = FocusNode();
  
  DateTime deliveryDate = DateTime.now();
  DateTime expirationDate = DateTime.now();
  int farmId;
   AddPharmaceuticalPage({required this.farmId});

  @override
  Widget build(BuildContext context) {
   TextStyle textstyle=TextStyle(color: ColorPalette.colorFontTextFieldPrincipal,fontWeight: FontWeight.w700);
    return SafeArea(child: Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, top: 20,right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectImageWidget(diameter: 180, color: Colors.grey.shade200, onChange: (File file){}),
                const SizedBox(
                  height: 20,
                ),
                CustomFormField(
                    textEditingController: meditationNameController,
                    validator: ValidatorTextField.genericStringValidator,
                    nextFocusNode: providerNameNode,
                    focusNode: meditationNode,
                    hintText: "Derri A plus",
                    labelText: "Nombre del medicamento",
                    obscureText: false),
                CustomFormField(
                    textEditingController: providerNameController,
                    validator: ValidatorTextField.genericStringValidator,
                    nextFocusNode: priceNode,
                    focusNode: providerNameNode,
                    hintText: "S.A. Ejemplo",
                    labelText: "Nombre del proveedor",
                    obscureText: false),
                CustomFormField(
                    textInput: TextInputType.number,
                    textEditingController: priceController,
                    validator: ValidatorTextField.genericDecimalValidator,
                    nextFocusNode: null,
                    focusNode: priceNode,
                    hintText: r"C$500",
                    labelText: "Precio",
                    obscureText: false),
                    SizedBox(height: 25),
                     Text(
                    "fecha: ${ DateFormat('hh:mm:ss').format(expirationDate!)}",style: textstyle,),
                const SizedBox(height: 8,),
                  DateTimePicker(text: "Fecha de caducidad", size: const Size(275,31), date: expirationDate,color: ColorPalette.colorFontTextFieldPrincipal,),
                    SizedBox(height: 35,),
                     Text(
                    "fecha: ${ DateFormat('hh:mm:ss').format(deliveryDate!)}",style: textstyle,),
                const SizedBox(height: 8,),
                  DateTimePicker(text: "Fecha de entrega", size: const Size(275,31), date: expirationDate,color: ColorPalette.colorFontTextFieldPrincipal,),
                const SizedBox(
                  height: 35,
                ),
                counterWidget(text: "Cantidad",),
                const SizedBox(height: 30,),
                Center(child: ButtonWidget(text: "Agregar", size: const Size(228, 61), color: ColorPalette.colorPrincipal, rounded: 25, function: (){
                   final FormState form = _formKey.currentState!;
                        if (form.validate()) {
                          print('Form is valid');
                        } else {
                          print('Form is invalid');
                        }
                }, fontSize: 16))
          ],
        ),
      ),),
    ));
  }
}

class counterWidget extends StatelessWidget {
  String text;
  counterWidget({
    required this.text
    
  });

  @override
  Widget build(BuildContext context) {

    return Row(children: [
      Text(text,style: TextStyle(color: ColorPalette.colorFontTextFieldPrincipal),),
      Counter(min: 1, max: double.infinity,)]);
  }
}