import 'package:flutter/material.dart';
import 'package:hackathon_app/ui/pages/principal_page.dart';

import '../config/color_palette.dart';
import '../util/validator_textfield.dart';
import '../widgets/button_widget.dart';
import '../widgets/custom_form_field.dart';
import '../widgets/text_button_widget.dart';

class LoginPage extends StatelessWidget {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final userNameFocus = FocusNode();
  final passwordFocus = FocusNode();
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 18.0, right: 18.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.2,
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
                  text: "Registrarse",
                  size: const Size(268, 57),
                  color: ColorPalette.colorPrincipal,
                  rounded: 25,
                  function: () {
                    final FormState form = _formKey.currentState!;
                    if (form.validate()) {
                      print('Form is valid');
                    } else {
                      print('Form is invalid');
                    }
                  },
                  fontSize: 16,
                ),
                SizedBox(
                  height: size.height * .03,
                ),
                TextButtonWidget(
                    text: "Iniciar sesión",
                    color: ColorPalette.colorPrincipal,
                    fontSize: 16,
                    function: () => principalPage(context))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void principalPage(context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => PrincipalPage()),
        (route) => false);
  }
}
