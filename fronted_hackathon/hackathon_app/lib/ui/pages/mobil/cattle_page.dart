import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_provider_utilities/flutter_provider_utilities.dart';
import 'package:hackathon_app/domain/models/Entities/flock.dart';
import 'package:hackathon_app/provider/cattle_provider.dart';
import 'package:hackathon_app/provider/farm_provider.dart';
import 'package:hackathon_app/provider/flock_provider.dart';
import 'package:hackathon_app/provider/meditation_provider.dart';
import 'package:hackathon_app/provider/user_provider.dart';
import 'package:hackathon_app/ui/config/color_palette.dart';
import 'package:hackathon_app/ui/pages/mobil/inventary_page.dart';
import 'package:hackathon_app/ui/util/path_image_asset.dart';
import 'package:hackathon_app/ui/util/validator_textfield.dart';
import 'package:hackathon_app/ui/widgets/button_widget.dart';
import 'package:hackathon_app/ui/widgets/flushbar_widget.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_card_widget.dart';
import '../../widgets/custom_form_field.dart';
import '../../widgets/search_bar.dart';
import '../../widgets/select_image_widget.dart';
import 'cow_page.dart';

class CattlePage extends StatelessWidget {
  String roleFarm = "Visitante";
  int farmId;
  String role;
  CattlePage({super.key, required this.farmId, required this.role});
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final farmProvider = Provider.of<FarmProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: MessageListener<FlockProvider>(
        showError: (error) {
          flushbarWidget(
              context: context, title: "Error", message: error, error: true);
        },
        showInfo: (info) {
          flushbarWidget(context: context, title: "Enhorabuena", message: info);
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              "Rebaños",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            foregroundColor: Colors.black,
            actions: [
              Visibility(
                visible: role == "Visitante" ? false : true,
                child: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog.adaptive(
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "🐮 Compartir finca",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Seleccione el rol que va a desempeñar",
                                  style: TextStyle(fontSize: 15),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                roleDropDown(),
                                SizedBox(
                                  height: 20,
                                ),
                                Selector<FarmProvider, String?>(
                                  builder: (context, value, child) {
                                    if (value != null) {
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                        Text("Toca el link:",style: TextStyle(color: Colors.red)),
                                        const SizedBox(height: 5,),
                                        CustomToolTip(text: value,)
                                      ]);
                                    }
                                    return Container();
                                  },
                                  selector: (p0, p1) => p1.token,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                ButtonWidget(
                                    text: "Crear",
                                    size: const Size(100, 50),
                                    color: Colors.blue,
                                    rounded: 12,
                                    function: () async {
                                      await farmProvider.inviteToFarm(farmId,
                                          role, userProvider.user!.userId!);
                                    },
                                    fontSize: 12)
                              ],
                            ),
                          );
                        },
                      );
                    },
                    icon: Icon(
                      Icons.share,
                      color: Colors.blue,
                    )),
              )
            ],
          ),
          floatingActionButton: addGroupWidget(
            farmId: farmId,
          ),
          body: Container(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: SingleChildScrollView(
              child: Column(children: [
                const SizedBox(
                  height: 20,
                ),
                searchBar(
                    function: (value) {},
                    controller: _controller,
                    height: 35,
                    padding: 16,
                    iconColor: const Color(0xffABA5A5),
                    backgroundColor: const Color(0xFFf2f2f2)),
                inventaryButton(farmId: farmId),
                SizedBox(
                  width: size.width,
                  height: size.height * 0.8,
                  child: groupList(farmId: farmId, role: role),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomToolTip extends StatelessWidget {
  String text;

  CustomToolTip({required this.text});

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: new Tooltip(
          preferBelow: false, message: "Copy", child: new Text(text,style: TextStyle(color: Colors.blue),)),
      onTap: () {
        Clipboard.setData(new ClipboardData(text: text));
      },
    );
  }
}

class roleDropDown extends StatefulWidget {
  roleDropDown({
    super.key,
  });

  @override
  State<roleDropDown> createState() => _roleDropDownState();
}

class _roleDropDownState extends State<roleDropDown> {
  String role = "Visitante";

  @override
  Widget build(BuildContext context) {
    final farmProvider = Provider.of<FarmProvider>(context, listen: false);
    return DropdownButton<String>(
      items: [
        DropdownMenuItem<String>(
          child: Text("Técnico"),
          value: "Técnico",
        ),
        DropdownMenuItem<String>(
          child: Text("Visitante"),
          value: "Visitante",
        ),
        DropdownMenuItem<String>(
          child: Text("Propietario"),
          value: "Propietario",
        ),
      ],
      onChanged: (value) {
        setState(() {
          role = value!;
          farmProvider.role = value;
        });
      },
      value: role,
    );
  }
}

class addGroupWidget extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController groupController = TextEditingController();
  FocusNode groupNode = FocusNode();
  File? file;
  int farmId;
  addGroupWidget({required this.farmId});

  @override
  Widget build(BuildContext context) {
    final flockProvider = Provider.of<FlockProvider>(context, listen: false);

    return FloatingActionButton.extended(
      elevation: 0,
      backgroundColor: ColorPalette.colorPrincipal,
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    SelectImageWidget(
                        diameter: 180,
                        color: Colors.grey.shade200,
                        onChange: (File fileU) {
                          file = fileU;
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomFormField(
                        textEditingController: groupController,
                        validator: ValidatorTextField.genericStringValidator,
                        nextFocusNode: null,
                        focusNode: groupNode,
                        hintText: "Rebaño #3",
                        labelText: "Nombre del grupo",
                        obscureText: false),
                    ButtonWidget(
                        text: "Agregar",
                        size: const Size(210, 30),
                        color: ColorPalette.colorPrincipal,
                        rounded: 20,
                        function: () async {
                          final FormState form = _formKey.currentState!;
                          if (form.validate()) {
                            Flock flock = Flock(
                                flockName: groupController.text,
                                farmId: farmId);
                            File fileImage = file ??
                                await PathImageAsset.getImageFileFromAssets(
                                    "images/sections/image.png");
                            flock.imageName = fileImage!.path.split("/").last;
                            flock.imagePath = fileImage.path;
                            await flockProvider.create(flock);
                            Navigator.pop(context);
                          }
                        },
                        fontSize: 14)
                  ],
                ),
              ),
            );
          },
        );
      },
      label: const Text(
        "Agregar grupo",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class inventaryButton extends StatelessWidget {
  int farmId;
  inventaryButton({required this.farmId});

  @override
  Widget build(BuildContext context) {
    final meditationProvider = Provider.of<MeditationProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(left: size.width * .05),
      child: TextButton(
          style: const ButtonStyle(splashFactory: NoSplash.splashFactory),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                if ((meditationProvider.t?.farmId) != farmId) {
                  meditationProvider.doNull();
                }
                meditationProvider.t?.farmId != farmId;

                return InventaryPage(farmId: farmId);
              },
            ));
          },
          child: Row(
            children: [
              Image.asset(
                "assets/images/icons/inventory.png",
                width: 36,
                height: 36,
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                "Inventario",
                style: TextStyle(
                    color: Color(0xFFCA78FF), fontWeight: FontWeight.bold),
              ),
            ],
          )),
    );
  }
}

class groupList extends StatelessWidget {
  String role;
  int farmId;
  groupList({required this.farmId, required this.role});

  @override
  Widget build(BuildContext context) {
    final cattleProvider = Provider.of<CattleProvider>(context, listen: false);
    final flockProvider = Provider.of<FlockProvider>(context, listen: true);
    return FutureBuilder(
      future: flockProvider.getAllFlockByFarmId(farmId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          List<Flock> flocks = snapshot.data!;
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: CustomCardWidget(null, onLongPress: () {}, function: () {
                  cattleProvider.doNull();
                  cowPage(context, flocks[index].flockId!, role);
                },
                    urlImage: flocks[index].flockImage!,
                    title: flocks[index].flockName,
                    description:
                        "Cantidad de ganado: ${flocks[index].cattleQuantity}",
                    radius: 12),
              );
            },
          );
        } else {
          return const Center(
            child: Text("Error en el servicio, intente nuevamente"),
          );
        }
      },
    );
  }

  void cowPage(BuildContext context, int idCastle, String role) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return CowPage(
          role: role,
          flockId: idCastle,
          IdFarm: farmId,
        );
      },
    ));
  }
}
