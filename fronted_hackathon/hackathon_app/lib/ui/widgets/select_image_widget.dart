import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker_widget/image_picker_widget.dart';

class SelectImageWidget extends StatelessWidget {


  double diameter;
  Color color;
  Function(File) onChange; 
  
  SelectImageWidget({
    required this.diameter,
    required this.color,
    required this.onChange
    
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ImagePickerWidget(
        backgroundColor: color,
        diameter: diameter,
        shape: ImagePickerWidgetShape.circle,
        isEditable: true,
        onChange:onChange
      ),
    );
  }
}