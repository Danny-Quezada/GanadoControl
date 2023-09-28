import 'package:flutter/material.dart';
import 'package:hackathon_app/ui/config/color_palette.dart';
import 'package:hackathon_app/ui/pages/web/principal_web_page.dart';
import 'package:hackathon_app/ui/pages/web/sig_in_web_page.dart';
import 'package:hackathon_app/ui/util/validator_textfield.dart';
import 'package:hackathon_app/ui/widgets/button_widget.dart';
import 'package:hackathon_app/ui/widgets/custom_form_field.dart';
import 'package:hackathon_app/ui/widgets/text_button_widget.dart';

class LogInWebPage extends StatelessWidget {
  LogInWebPage({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final userNameFocus = FocusNode();
  final passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Form(
            key: _formKey,
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: size.width * 0.05,
                      left: size.height * 0.05,
                      right: size.height * 0.1),
                  child: Image.asset(
                    'assets/images/sections/AccessAcount.png',
                    width: 579,
                    height: 489,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: size.width * 0.1,
                      left: size.height * 0.05,
                      right: size.height * 0.1),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 350,
                        child: CustomFormField(
                            textEditingController: userNameController,
                            validator: ValidatorTextField.userNameValidator,
                            nextFocusNode: passwordFocus,
                            focusNode: userNameFocus,
                            hintText: 'Nombre de usuario',
                            labelText: 'Nombre de usuario',
                            obscureText: false),
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      SizedBox(
                        width: 350,
                        child: CustomFormField(
                          textEditingController: passwordController,
                          validator: ValidatorTextField.passwordValidator,
                          nextFocusNode: null,
                          focusNode: passwordFocus,
                          hintText: 'Contraseña',
                          labelText: 'Contraseña',
                          obscureText: true,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.1,
                      ),
                      ButtonWidget(
                          text: 'Iniciar sesión',
                          size: const Size(284, 63),
                          color: ColorPalette.colorPrincipal,
                          rounded: 25,
                          function: () {
                            //TODO: Implementar logica de verificar la informacion del usuario e ir a la pagina principal
                            principalPage(context);
                          },
                          fontSize: 24),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      TextButtonWidget(
                          text: 'Registrarse',
                          color: ColorPalette.colorPrincipal,
                          fontSize: 24,
                          function: () => sigInPage(context)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void sigInPage(BuildContext context) {
    Navigator.of(context).push(
        PageRouteBuilder(pageBuilder: (context, animation, secundaryAnimation) {
      return SigInWebPage();
    }, transitionsBuilder: (context, animation, secundaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    }));
  }

  void principalPage(context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const PrincipalPageWeb()),
        (route) => false);
  }
}
