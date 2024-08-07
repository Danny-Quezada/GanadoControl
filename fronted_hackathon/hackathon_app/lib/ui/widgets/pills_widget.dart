import 'package:flutter/material.dart';
import 'package:hackathon_app/ui/config/color_palette.dart';

import '../../domain/models/enums/pharmaceuticals.dart';

class PillWidget extends StatelessWidget {
  String title;
  int? count;
  Pharmaceuticals pharmaceuticals;
  VoidCallback function;
  PillWidget(this.count,
      {super.key, required this.pharmaceuticals, required this.title,required this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                child: icon(),
                backgroundColor: containerColor(),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(title),
            ],
          ),
          count != null
              ? CircleAvatar(
                  radius: 14,
                  backgroundColor: containerColor(),
                  child: Text(
                    count!.toString(),
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w900),
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  Color containerColor() {
    if (pharmaceuticals == Pharmaceuticals.Medicamentos) {
      return ColorPalette.medicationColor;
    }
    if (pharmaceuticals == Pharmaceuticals.Vacunas) {
      return ColorPalette.vaccineColor;
    }
    return ColorPalette.vitaminColor;
  }

  icon() {
    if (pharmaceuticals == Pharmaceuticals.Medicamentos) {
      return Image.asset(
        "assets/images/icons/medication.png",
        width: 28,
        height: 28,
      );
    }
    if (pharmaceuticals == Pharmaceuticals.Vacunas) {
      return Image.asset(
        "assets/images/icons/vaccine.png",
        width: 28,
        height: 28,
      );
    }
    return Image.asset("assets/images/icons/vitamin.png",width: 28,height: 28,);
  }
}
