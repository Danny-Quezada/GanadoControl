import 'package:flutter/material.dart';
import 'package:hackathon_app/provider/treatment_provider.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../domain/models/Entities/cattle.dart';
import '../../../domain/models/Entities/treatment.dart';
import '../../../domain/models/enums/pharmaceuticals.dart';
import '../../config/color_palette.dart';
import '../../util/validator_textfield.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/custom_form_field.dart';
import '../../widgets/pills_widget.dart';
import '../../widgets/rich_text_widget.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
PersistentBottomSheetController? _controller;

class CowInformationPage extends StatelessWidget {
  Cattle cattle;
  CowInformationPage({super.key, required this.cattle});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          if (_controller != null) {
            _controller!.close();
          }
        },
        child: Scaffold(
          key: _scaffoldKey,
          body: Stack(
            children: [
              Container(
                color: Colors.grey.shade100,
                width: size.width,
                height: size.height * .3,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  width: size.width,
                  height: size.height * .8,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        CircleAvatar(
                          backgroundColor:
                              Colors.grey.shade100.withOpacity(0.8),
                          radius: size.width * .2,
                          child:
                              Image.asset("assets/images/sections/image.png"),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Identificador",
                          style: TextStyle(
                              fontFamily: "Karla", fontWeight: FontWeight.bold),
                        ),
                        Text(
                          cattle.idCattle.toString(),
                          style: TextStyle(
                              color: ColorPalette.colorFontTextFieldPrincipal,
                              fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        OptionMenu(cattle: cattle),
                        const ListMedical()
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ListMedical extends StatelessWidget {
  const ListMedical({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height * 0.5,
      child: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: PillWidget(2,
                pharmaceuticals: Pharmaceuticals.Vacunas,
                title: "Derri A plus",
                function: () {}),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: PillWidget(2,
                pharmaceuticals: Pharmaceuticals.Medicamentos,
                title: "Marbox", function: () {
              //_showDetailsTreatment(Treatment(cattleId: catt, meditationId: meditationId, date: date, type: type, dosis: dosis, observation: observation, aplicationArea: aplicationArea), context)
            }),
          )
        ],
      ),
    );
  }

  _showDetailsTreatment(Treatment treatment, BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(treatment.meditationName!),
                RichTextWidget(
                    title: "Día: ",
                    content: DateFormat('hh:mm:ss').format(treatment.date!)),
                RichTextWidget(
                    title: "Dosis", content: treatment.dosis.toString()),
                RichTextWidget(
                  title: "Área: ",
                  content: treatment.aplicationArea,
                ),
                const Text("Observaciones",
                    style: TextStyle(color: Colors.red)),
                Text(treatment.observation)
              ],
            ),
          ),
        );
      },
    );
  }
}

class OptionMenu extends StatefulWidget {
  Cattle cattle;
  OptionMenu({required this.cattle});

  @override
  State<OptionMenu> createState() => _OptionMenuState();
}

class _OptionMenuState extends State<OptionMenu> {
  String value = "Todo";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(12),
                border: Border.all(color: Colors.grey.shade100, width: 2)),
            child: DropdownButton(
              items: const [
                DropdownMenuItem(
                  child: Text("Todo"),
                  value: "Todo",
                ),
                DropdownMenuItem(
                  child: Text("Medicamentos"),
                  value: "Medicamentos",
                ),
                DropdownMenuItem(
                  child: Text("Vitaminas"),
                  value: "Vitaminas",
                ),
                DropdownMenuItem(child: Text("Vacunas"), value: "Vacunas"),
              ],
              style:
                  TextStyle(color: Colors.grey.shade400, fontFamily: "Karla"),
              underline: Container(),
              value: value,
              elevation: 5,
              onChanged: (valuee) {
                setState(() {
                  value = valuee!;
                });
              },
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: Image.asset("assets/images/icons/calendar.png")),
          IconButton(
              onPressed: () {},
              icon: Image.asset("assets/images/icons/cowFamily.png")),
          IconButton(
              onPressed: () {
                _controller = _scaffoldKey.currentState!.showBottomSheet(
                    backgroundColor: Colors.white,
                    (context) => addTreatmentBottomSheet(
                          cattleId: widget.cattle.idCattle,
                          type: widget.cattle.type,
                        ));
              },
              icon: Image.asset("assets/images/icons/greenPlus.png"))
        ],
      ),
    );
  }
}

class addTreatmentBottomSheet extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController dosisController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController observationController = TextEditingController();

  FocusNode dosisNode = FocusNode();
  FocusNode areaNode = FocusNode();
  FocusNode observationNode = FocusNode();

  String cattleId;
  String type;
  addTreatmentBottomSheet({required this.cattleId, required this.type});

  @override
  Widget build(BuildContext context) {
    var treatmentProvider =
        Provider.of<TreatmentProvider>(context, listen: false);
    return Form(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomFormField(
                textEditingController: dosisController,
                validator: ValidatorTextField.genericStringValidator,
                nextFocusNode: areaNode,
                focusNode: dosisNode,
                hintText: "",
                labelText: "Dósis",
                obscureText: false),
            CustomFormField(
                textEditingController: areaController,
                validator: ValidatorTextField.genericStringValidator,
                nextFocusNode: observationNode,
                focusNode: areaNode,
                hintText: "Detrás del hombro",
                labelText: "Área de aplicación",
                obscureText: false),
            CustomFormField(
                textEditingController: observationController,
                validator: ValidatorTextField.genericDecimalValidator,
                nextFocusNode: null,
                focusNode: observationNode,
                hintText: "Molestias en la parte de la aplicación",
                labelText: "Observación",
                obscureText: false),
            ButtonWidget(
              color: const Color(0xFFCA78FF),
              fontSize: 16,
              size: const Size(261, 31),
              function: () async {
                // final FormState? form = _formKey.currentState;
                // if (form!.validate()) {
                Treatment treatment = Treatment(
                    cattleId: 'dj',
                    meditationId: 1.toString(),
                    date: DateTime.now(),
                    type: type,
                    dosis: double.parse(dosisController.text),
                    observation: observationController.text,
                    aplicationArea: areaController.text);
                await treatmentProvider.create(treatment);
                // }
              },
              rounded: 12,
              text: "Elegir fármaco",
            )
          ],
        ),
      ),
    );
  }
}
