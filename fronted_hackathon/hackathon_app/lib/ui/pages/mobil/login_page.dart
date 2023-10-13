import 'package:flutter/material.dart';
import 'package:flutter_provider_utilities/flutter_provider_utilities.dart';
import 'package:hackathon_app/app_core/services/shared_preferences_services.dart';
import 'package:hackathon_app/provider/user_provider.dart';
import 'package:hackathon_app/ui/config/color_palette.dart';
import 'package:hackathon_app/ui/pages/mobil/principal_page.dart';
import 'package:hackathon_app/ui/pages/mobil/sign_in_page.dart';
import 'package:hackathon_app/ui/util/validator_textfield.dart';
import 'package:hackathon_app/ui/widgets/button_widget.dart';
import 'package:hackathon_app/ui/widgets/custom_form_field.dart';
import 'package:hackathon_app/ui/widgets/flushbar_widget.dart';
import 'package:hackathon_app/ui/widgets/text_button_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  final Stopwatch _stopwatch = Stopwatch();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final userNameFocus = FocusNode();
  final passwordFocus = FocusNode();
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: MessageListener<UserProvider>(
        showInfo: (info) {},
        showError: (info) {
          flushbarWidget(
              context: context, title: "Error", message: info, error: true);
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(left: 18.0, right: 18.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.17,
                    ),
                    Center(
                        child: Image.asset(
                      "assets/images/sections/AccessAcount.png",
                      width: 232,
                      height: 187,
                    )),
                    SizedBox(
                      height: size.height * .05,
                    ),
                    CustomFormField(
                        hintText: "Ejemplo dan",
                        labelText: "Nombre de usuario",
                        obscureText: false,
                        textEditingController: userNameController,
                        validator: ValidatorTextField.userNameValidator,
                        nextFocusNode: passwordFocus,
                        focusNode: userNameFocus),
                    CustomFormField(
                        hintText: "**********",
                        labelText: "Contraseña",
                        obscureText: true,
                        textEditingController: passwordController,
                        validator: ValidatorTextField.passwordValidator,
                        nextFocusNode: null,
                        focusNode: passwordFocus),
                    SizedBox(
                      height: size.height * .05,
                    ),
                    ButtonWidget(
                      text: "Iniciar sesión",
                      size: const Size(268, 57),
                      color: ColorPalette.colorPrincipal,
                      rounded: 25,
                      function: () async {
                        _stopwatch.start();
                        final FormState form = _formKey.currentState!;
                        if (form.validate()) {
                          await userProvider.verifyUser(
                              userNameController.text, passwordController.text);
                          _stopwatch.stop();

                          if (userProvider.user != null) {
                            principalPage(context);
                          }
                        } else {}
                      },
                      fontSize: 16,
                    ),
                    SizedBox(
                      height: size.height * .018,
                    ),
                    TextButtonWidget(
                        text: "Registrarse",
                        color: ColorPalette.colorPrincipal,
                        fontSize: 16,
                        function: () {
                          userProvider.changeError();
                          signInPage(context);
                        }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void principalPage(context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const PrincipalPage()),
        (route) => false);
  }

  void signInPage(context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => SignInPage()),
        (route) => false);
  }
}
