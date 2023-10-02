import 'package:flutter/material.dart';
import 'package:hackathon_app/domain/models/Entities/body_part.dart';
import 'package:hackathon_app/provider/body_part_provider.dart';
import 'package:provider/provider.dart';
import 'package:path_drawing/path_drawing.dart';

class CowPartWidget extends StatelessWidget {
  const CowPartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final bodyPartProvider = Provider.of<BodyPartProvider>(context);

    bodyPartProvider.loadParts();
    return bodyPartProvider.bodyParts == []
        ? CircularProgressIndicator()
        : Container(
       
        height: size.height * .4,
        width: size.width,
        child: InteractiveViewer(
          
          scaleFactor: 0.01,
          maxScale: 5,
          minScale: 0.0004,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Stack(
            children: [
              for (var bodyPart in bodyPartProvider.bodyParts)
                ClippedImage(
                  clipper: Clipper(
                    svgPath: bodyPart.path,
                  ),
                  color: bodyPart.isSelected ? Colors.red : Colors.black,
                  bodyPart: bodyPart,
                ),
            ],
          ),
        ),
          );
  }
}

class Clipper extends CustomClipper<Path> {
  Clipper({
    required this.svgPath,
  });

  String svgPath;

  @override
  Path getClip(Size size) {
    var path = parseSvgPathData(svgPath);
    final Matrix4 matrix4 = Matrix4.identity();

    // path.moveTo(0.5,0.5);

    // path.lineTo(size.width, 0);
    //matrix4.scale(size.width*0.9/size.width,size.height*0.4/size.height);
    matrix4.scale(0.7, 0.7);

    return path.transform(matrix4.storage).shift(Offset(size.width * .1, 0));
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}

class ClippedImage extends StatelessWidget {
  Clipper clipper;
  Color color;
  BodyPart bodyPart;

  ClippedImage(
      {required this.clipper, required this.color, required this.bodyPart});

  @override
  Widget build(BuildContext context) {
    final bodyPartProvider =
        Provider.of<BodyPartProvider>(context, listen: false);
    return ClipPath(
      clipper: clipper,
      child: GestureDetector(
        onTap: () {
          bodyPart.isSelected = !bodyPart.isSelected;
          bodyPartProvider.changeSelection(bodyPart);
        },
        child: Container(
          color: color,
        ),
      ),
    );
  }
}
