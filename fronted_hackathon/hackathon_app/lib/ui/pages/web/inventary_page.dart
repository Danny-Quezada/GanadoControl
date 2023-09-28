import 'package:flutter/material.dart';
import 'package:hackathon_app/domain/models/Entities/meditation.dart';
import 'package:hackathon_app/domain/models/enums/inventory.dart';
import 'package:hackathon_app/domain/models/enums/pharmaceuticals.dart';
import 'package:hackathon_app/ui/config/color_palette.dart';
import 'package:hackathon_app/ui/widgets/pills_widget.dart';
import 'package:intl/intl.dart';

class InventoryWebPage extends StatefulWidget {
  const InventoryWebPage({super.key});

  @override
  State<InventoryWebPage> createState() => _InventoryWebPageState();
}

class _InventoryWebPageState extends State<InventoryWebPage> {
  Inventory select = Inventory.all;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: const Center(
          child: Text(
            'Inventario',
            style: TextStyle(color: Colors.black),
          ),
        ),
        actions: const [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
                'https://upload.wikimedia.org/wikipedia/commons/3/3c/Tom_Holland_by_Gage_Skidmore.jpg'),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Row(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      options(() {
                        setState(() {
                          select = Inventory.all;
                        });
                      }, 'Todas', select == Inventory.all),
                      const SizedBox(
                        width: 25,
                      ),
                      options(() {
                        setState(() {
                          select = Inventory.categories;
                        });
                      }, 'Categorias', select == Inventory.categories),
                    ],
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                            alignment: Alignment.topCenter,
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            height: 35,
                            width: 452,
                            child: const SearchBar(
                              elevation: MaterialStatePropertyAll<double?>(0),
                              leading: Icon(
                                Icons.search,
                                color: Color(0xffABA5A5),
                              ),
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                  Color(0xFFf2f2f2)),
                            )),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              'assets/images/icons/greenPlus.png',
                              height: 25.28,
                              width: 25.28,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 35,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFC1C1C1))),
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * .75,
              child: Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 75,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          'Fármaco',
                          style: TextStyle(
                              fontFamily: 'Monserrat',
                              fontSize: 28,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                      SizedBox(
                        width: (MediaQuery.of(context).size.width * 0.8) / 6,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          'Categoría',
                          style: TextStyle(
                              fontFamily: 'Monserrat',
                              fontSize: 28,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                      SizedBox(
                        width: (MediaQuery.of(context).size.width * 0.8) / 6,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          'Cantidad',
                          style: TextStyle(
                              fontFamily: 'Monserrat',
                              fontSize: 28,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                      SizedBox(
                        width: (MediaQuery.of(context).size.width * 0.8) / 6,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          'Precio',
                          style: TextStyle(
                              fontFamily: 'Monserrat',
                              fontSize: 28,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                      // SizedBox(
                      //   width: (MediaQuery.of(context).size.width * 0.8) / 5,
                      // ),
                    ],
                  ),
                  //todo:Agregar la logica para generar la lista de los medicamentos y retornarlos en row
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget options(void Function() function, String text, bool select) {
    return InkWell(
      onTap: function,
      child: Column(
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 24, fontFamily: 'Karla'),
          ),
          Visibility(
              visible: select,
              child: Container(
                width: text.length * 14,
                height: 3,
                color: ColorPalette.colorPrincipal,
              ))
        ],
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
