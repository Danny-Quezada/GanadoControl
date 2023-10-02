import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackathon_app/domain/models/Entities/physical_problem.dart';
import 'package:xml/xml.dart';

import '../domain/models/Entities/body_part.dart';

class BodyPartProvider with ChangeNotifier {
  String cattleId = "";
  List<BodyPart> bodyParts = [];
  List<PhysicalProblem> physicalProblems = [];
  loadParts() async {
   if(bodyParts.isNotEmpty){
      return;
    }
      bodyParts = await loadSvgImage();
    
    notifyListeners();
  }

  Future<List<BodyPart>> loadSvgImage() async {
    List<BodyPart> bodyParts = [];

    String generalString =
        await rootBundle.loadString(r"assets/svg/cowPartINK.svg");

    XmlDocument document = XmlDocument.parse(generalString);

    final paths = document.findAllElements('path');

    for (var element in paths) {
      String partId = element.getAttribute('id').toString();
      String partPath = element.getAttribute('d').toString();
      String parte = element.getAttribute('parte').toString();
      bodyParts
          .add(BodyPart(isSelected: false, partName: parte, path: partPath));
    }

    return bodyParts;
  }

  changeSelection(BodyPart body) {
    bodyParts
        .firstWhere((element) => element.partName == body.partName)
        .isSelected = body.isSelected;
    if (body.isSelected) {
      physicalProblems.add(PhysicalProblem(
          cattleId: cattleId, partName: body.partName, description: ""));
    } else {
      physicalProblems
          .removeWhere((element) => element.partName == body.partName);
    }
    notifyListeners();
  }

  changeDescription(String text, int) {}
}
