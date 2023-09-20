import 'package:flutter/material.dart';
import 'package:hackathon_app/ui/config/color_palette.dart';

class CustomFormField extends StatelessWidget {

  final FormFieldValidator<String>? validator;
  final TextEditingController textEditingController;
  final FocusNode? nextFocusNode;
  final FocusNode? focusNode;
  final String hintText;
  final String labelText;
  bool obscureText;
  
  CustomFormField(
      {
        required this.textEditingController,
      required this.validator,
      required this.nextFocusNode,
      required this.focusNode,
      required this.hintText,
      required this.labelText,
      required this.obscureText});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      onFieldSubmitted: (_)=>nextFocusNode?.requestFocus(),
      controller: textEditingController,
      keyboardType: TextInputType.emailAddress,
      
      decoration: InputDecoration(
        
        hintStyle: TextStyle(color:ColorPalette.colorFontTextFieldPrincipal),
        labelStyle: TextStyle(color:ColorPalette.colorFontTextFieldPrincipal),
        hintText: hintText,
        labelText: labelText,
        helperText: "",
        
      ),
      validator: validator,
      obscureText: obscureText,
    );
  }
}
