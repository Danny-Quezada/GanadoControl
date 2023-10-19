import 'package:flutter/material.dart';

class CustomCardWidget extends StatelessWidget {
  String urlImage;
  String title;
  String description;
  List<String>? labelChip;
  VoidCallback onLongPress;
  bool? isSelected;
  VoidCallback function;
  double radius;

  CustomCardWidget(this.labelChip,
      {required this.function,
      required this.urlImage,
      required this.title,
      required this.description,
      required this.radius,
      this.isSelected = false,
      required this.onLongPress});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onLongPress: onLongPress,
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.only(top: 2),
        child: Stack(children: [
          Container(
            width: size.width,
            height: size.height * .166,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                border: Border.all(color: Colors.grey.shade300, width: 2)),
            alignment: Alignment.center,
            child: Row(
              children: [
                const SizedBox(
                  width: 8,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  height: size.height * .12,
                  width: size.width * .20,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius:
                          BorderRadius.all(Radius.circular(radius - 6))),
                ),
                SizedBox(
                  width: size.width * .03,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 10,
                    ),
                    height: size.height * .15,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                        Text(description,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 8,
                            style: const TextStyle(fontSize: 12)),
                        chips()
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Visibility(
              visible: isSelected!,
              child: Container(
                width: size.width,
                height: size.height * .166,
                color: Colors.blue.withOpacity(0.1),
              ))
        ]),
      ),
    );
  }

  Widget chips() {
    List<Color> colors = [Colors.pink.shade200, Colors.blueGrey.shade300];

    if (labelChip == null) {
      return Container();
    }
    List<Widget> chips = [];
    for (int i = 0; i < labelChip!.length; i++) {
      chips.add(Transform(
        transform: new Matrix4.identity()..scale(0.8),
        child: Chip(
          label: Text(
            labelChip![i],
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: colors[i],
        ),
      ));
    }
    return Row(
      children: chips,
    );
  }
}
