import 'package:flutter/material.dart';
import 'package:hackathon_app/ui/config/color_palette.dart';
import 'package:hackathon_app/ui/pages/web/log_in_web_page.dart';
import 'package:hackathon_app/ui/pages/web/principal_web_page.dart';
import 'package:hackathon_app/ui/util/validator_textfield.dart';
import 'package:hackathon_app/ui/widgets/button_widget.dart';
import 'package:hackathon_app/ui/widgets/custom_form_field.dart';
import 'package:hackathon_app/ui/widgets/text_button_widget.dart';

class SigInWebPage extends StatelessWidget {
  SigInWebPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();
  final emailController = TextEditingController();

  final userNameFocus = FocusNode();
  final passwordFocus = FocusNode();
  final passwordConfirmationFocus = FocusNode();
  final emailFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.only(
              right: size.height * 0.05,
            ),
            child: Row(
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: size.width * 0.5,
                      height: size.height * 0.15,
                    ),
                    SizedBox(
                      width: 350,
                      child: CustomFormField(
                          textEditingController: userNameController,
                          validator: ValidatorTextField.userNameValidator,
                          nextFocusNode: userNameFocus,
                          focusNode: passwordFocus,
                          hintText: 'Nombre de usuario',
                          labelText: 'Nombre de usuario',
                          obscureText: false),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    SizedBox(
                      width: 350,
                      child: CustomFormField(
                          textEditingController: passwordController,
                          validator: ValidatorTextField.passwordValidator,
                          nextFocusNode: passwordConfirmationFocus,
                          focusNode: passwordFocus,
                          hintText: 'Contraseña',
                          labelText: 'Contraseña',
                          obscureText: true),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    SizedBox(
                      width: 350,
                      child: CustomFormField(
                          textEditingController: passwordConfirmationController,
                          validator: ValidatorTextField.passwordValidator,
                          nextFocusNode: emailFocus,
                          focusNode: passwordConfirmationFocus,
                          hintText: 'Confirmar contraseña',
                          labelText: 'Confirmar contraseña',
                          obscureText: true),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    SizedBox(
                      width: 350,
                      child: CustomFormField(
                          textEditingController: emailController,
                          validator: ValidatorTextField.emailValidator,
                          nextFocusNode: null,
                          focusNode: emailFocus,
                          hintText: 'E-mail',
                          labelText: 'E-mail',
                          obscureText: false),
                    ),
                    SizedBox(
                      height: size.height * 0.07,
                    ),
                    ButtonWidget(
                        text: 'Registrarse',
                        size: const Size(284, 63),
                        color: ColorPalette.colorPrincipal,
                        rounded: 25,
                        function: () {
                          //TODO:Implementar logica de registrar e ir a la pagina principal
                          principalPage(context);
                        },
                        fontSize: 24),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    TextButtonWidget(
                        text: 'Iniciar sesión',
                        color: ColorPalette.colorPrincipal,
                        fontSize: 24,
                        function: () => logInPage(context)),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: size.width * 0.0001, right: size.height * 0.004
                      // left: size.height * 0.01,
                      ),
                  child: Image.asset(
                    'assets/images/sections/SignUp.png',
                    width: 579,
                    height: 489,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void logInPage(BuildContext context) {
    Navigator.of(context).push(
        PageRouteBuilder(pageBuilder: (context, animation, secundaryAnimation) {
      return LogInWebPage();
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
