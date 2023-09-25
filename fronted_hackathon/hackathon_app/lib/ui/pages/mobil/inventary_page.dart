import 'package:flutter/material.dart';
import 'package:hackathon_app/domain/models/Entities/meditation.dart';
import 'package:hackathon_app/domain/models/enums/pharmaceuticals.dart';
import 'package:hackathon_app/ui/config/color_palette.dart';
import 'package:hackathon_app/ui/pages/mobil/add_pharmaceutical_page.dart';
import 'package:hackathon_app/ui/pages/mobil/cow_page.dart';
import 'package:hackathon_app/ui/widgets/pills_widget.dart';
import 'package:hackathon_app/ui/widgets/search_bar.dart';
import 'package:intl/intl.dart';

class InventaryPage extends StatelessWidget {
  TextEditingController _controller = TextEditingController();
  int farmId;
  InventaryPage({required this.farmId});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(child: const Icon(Icons.add,color: Colors.white,),onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return AddPharmaceuticalPage(farmId: farmId);
            },
          ));
        }),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
          child: Column(
            children: [
              searchBar(
                  controller: _controller,
                  height: 35,
                  padding: 16,
                  iconColor: const Color(0xffABA5A5),
                  backgroundColor: const Color(0xFFf2f2f2)),
              SizedBox(
                width: size.width,
                height: size.height * .9,
                child: pharmaceuticalList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class pharmaceuticalList extends StatelessWidget {
  const pharmaceuticalList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 20),
      children: [
        PillWidget(
          2,
          pharmaceuticals: Pharmaceuticals.vaccine,
          title: "Derri A plus",
          function: () {
            _showDetailsPharmaceutical(
                Meditation(
                    meditationName: "Derri A plus",
                    provider: "nose",
                    type: "dfaf",
                    measurementUnit: "ml",
                    expirationDate: DateTime.now(),
                    deliveryDate: DateTime.now(),
                    price: "33",
                    quantity: 333,
                    urlPhoto: "",
                    farmId: 2),
                context);
          },
        )
      ],
    );
  }

  _showDetailsPharmaceutical(Meditation meditation, BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(meditation.meditationName),
              _richText("Fecha de caducidad: ",
                  DateFormat('hh:mm:ss').format(meditation.expirationDate!)),
              _richText("Fecha de entrega: ",
                  DateFormat('hh:mm:ss').format(meditation.deliveryDate!)),
              _richText("Precio: ", meditation.price),
              _richText("Cantidad: ", meditation.quantity.toString()),
            ],
          ),
        );
      },
    );
  }

  _richText(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
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
