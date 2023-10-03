import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackathon_app/ui/config/color_palette.dart';

class CustomFormField extends StatelessWidget {
  final FormFieldValidator<String>? validator;
  final TextEditingController textEditingController;
  final FocusNode? nextFocusNode;
  final FocusNode? focusNode;
  final String hintText;
  final String labelText;
  TextInputType? textInput;
  bool obscureText;
  bool? border;
  CustomFormField(
      {this.textInput = TextInputType.emailAddress,
      required this.textEditingController,
      required this.validator,
      required this.nextFocusNode,
      required this.focusNode,
      required this.hintText,
      required this.labelText,
      required this.obscureText,
      this.border = true});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      onFieldSubmitted: (_) => nextFocusNode?.requestFocus(),
      controller: textEditingController,
     
      minLines: 1,
      maxLines: border! ? 1: 10,
      keyboardType: textInput,
      decoration: InputDecoration(
        border: border == false ? InputBorder.none : null,
        hintStyle: TextStyle(color: ColorPalette.colorFontTextFieldPrincipal),
        labelStyle: TextStyle(color: ColorPalette.colorFontTextFieldPrincipal),
        hintText: hintText,
        labelText: labelText,
        helperText: "",
      ),
      validator: validator,
      obscureText: obscureText,
    );
  }
}
