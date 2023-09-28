
import 'package:flutter/material.dart';
import 'package:hackathon_app/ui/config/color_palette.dart';

class RichTextWidget extends StatelessWidget {


  String title;
  String content;
  double padding;
  RichTextWidget({required this.title, required this.content,this.padding=20});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: padding),
      child: RichText(
        text: TextSpan(
          // Note: Styles for TextSpans must be explicitly defined.
          // Child text spans will inherit styles from parent
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.black,
          ),
          children: <TextSpan>[
            TextSpan(
                text: title,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(
                text: content,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: ColorPalette.colorFontTextFieldPrincipal)),
          ],
        ),
      ),
    );
  }
}