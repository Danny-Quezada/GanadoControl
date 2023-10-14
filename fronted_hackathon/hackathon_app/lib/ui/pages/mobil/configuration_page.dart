import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_app/app_core/services/shared_preferences_services.dart';
import 'package:hackathon_app/provider/igeneric_provider.dart';
import 'package:hackathon_app/provider/user_provider.dart';
import 'package:hackathon_app/ui/config/color_palette.dart';
import 'package:hackathon_app/ui/pages/mobil/change_account_page.dart';
import 'package:hackathon_app/ui/pages/mobil/initial_page.dart';
import 'package:hackathon_app/ui/pages/mobil/login_page.dart';
import 'package:hackathon_app/ui/util/provider_null.dart';
import 'package:hackathon_app/ui/widgets/configuration_widget.dart';
import 'package:provider/provider.dart';

class ConfigurationPage extends StatelessWidget {
  const ConfigurationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: _appBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            UserInformation(),
            const SizedBox(
              height: 20,
            ),
            ConfigurationOption(widgets: [
              ConfigurationWidget(
                  function: () {},
                  iconData: Icons.person_pin_circle,
                  color: ColorPalette.editProfilerColor,
                  text: "Editar perfil"),
              ConfigurationWidget(
                  function: () async {
                    final userProvider =
                        Provider.of<UserProvider>(context, listen: false);
                    await SharedPreferencesServices.removeUser();
                    ProviderNull.providerNull(context);

                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangeAccountPage()),
                        (route) => false);
                  },
                  iconData: Icons.change_circle_sharp,
                  color: ColorPalette.changeAccountColor,
                  text: "Cambiar cuenta"),
            ]),
            const SizedBox(
              height: 20,
            ),
            ConfigurationOption(widgets: [
              ConfigurationWidget(
                  function: () => showSecurityAlert(context),
                  iconData: Icons.security_rounded,
                  color: ColorPalette.securityColor,
                  text: "Seguridad"),
              ConfigurationWidget(
                  function: () async {
                    final userProvider =
                        Provider.of<UserProvider>(context, listen: false);
                    await SharedPreferencesServices.removeUser();
                    ProviderNull.providerNull(context);
                    int count = (await userProvider.readUser()).length;

                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              count > 0 ? ChangeAccountPage() : InitialPage(),
                        ),
                        (route) => false);
                  },
                  iconData: Icons.outlined_flag_sharp,
                  color: ColorPalette.closeColor,
                  text: "Cerrar sesión"),
            ])
          ],
        ),
      ),
    ));
  }

  void showSecurityAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 10),
        title: Text(
          "Seguridad para tí",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
            child: ListBody(
          children: [
            Text.rich(TextSpan(
                text: "🔏 Use contraseñas fuertes:",
                style: TextStyle(fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                      text: " Combine letras, números y símbolos",
                      style: TextStyle(fontWeight: FontWeight.normal))
                ])),
            const SizedBox(
              height: 25,
            ),
            Text.rich(TextSpan(
                text: "🔄️ Actualice regularmente: ",
                style: TextStyle(fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                      text:
                          "Asegúrese de tener la versión más reciente de nuestra aplicación",
                      style: TextStyle(fontWeight: FontWeight.normal))
                ])),
            const SizedBox(
              height: 25,
            ),
            Text.rich(TextSpan(
                text: "🚫 Informe actividades sospechosas: ",
                style: TextStyle(fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                      text:
                          "Si nota algo inusual, ¡déjenos saber inmediatamente!",
                      style: TextStyle(fontWeight: FontWeight.normal))
                ]))
          ],
        )),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text("CONFIGURACION",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.white,
    );
  }
}

class ConfigurationOption extends StatelessWidget {
  List<Widget> widgets;
  ConfigurationOption({super.key, required this.widgets});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: ColorPalette.containerConfigurationColor,
      ),
      child: Column(
          children: widgets
              .map((e) => Padding(
                    padding: EdgeInsets.only(
                        right: 20, left: 20, top: 10, bottom: 10),
                    child: e,
                  ))
              .toList()),
    );
  }
}

class UserInformation extends StatelessWidget {
  const UserInformation({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          userProvider.user!.userName,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          userProvider.user!.workstation,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: ColorPalette.colorFontTextFieldPrincipal),
        )
      ],
    );
  }
}
