import 'package:flutter/material.dart';
import 'package:hackathon_app/ui/util/validator_textfield.dart';
import 'package:hackathon_app/ui/widgets/custom_form_field.dart';
import 'package:hackathon_app/ui/widgets/text_button_widget.dart';

import '../config/color_palette.dart';
import '../widgets/button_widget.dart';

class SignInPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();
  final emailController = TextEditingController();

  final userNameFocus = FocusNode();
  final passwordFocus = FocusNode();
  final passwordConfirmationFocus = FocusNode();
  final emailFocus = FocusNode();
  SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    ValidatorTextField validator=ValidatorTextField();
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        
          body: Container(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0),
            child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  
                  child: Column(
                    children: [
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Center(
                        child: Image.asset(
                      "assets/images/sections/SignUp.png",
                      width: 232,
                      height: 187,
                    )),
                      SizedBox(
                      height: size.height * 0.05,
                    ),
                    CustomFormField(
                      hintText: "Nombre de usuario",
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
                        nextFocusNode: passwordConfirmationFocus,
                        
                        focusNode: passwordFocus),
                        CustomFormField(
                      hintText: "**********",
                      labelText: "Confirmar contraseña",
                      obscureText: true,
                        textEditingController: passwordConfirmationController,
                        validator: (value) {
                          validator.password=passwordController.text;
                          return validator.passwordConfirmationValidator(value, validator.password);
                        },
                        nextFocusNode: emailFocus,
                        
                        focusNode: passwordConfirmationFocus),
                    CustomFormField(
                      hintText: "ejemplo@gmail.com",
                      labelText: "Email",
                      obscureText: false,
                        textEditingController: emailController,
                        validator: ValidatorTextField.emailValidator,
                        nextFocusNode: null,
                        focusNode: emailFocus),
                          SizedBox(
                      height: size.height * 0.035,
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
                    SizedBox(height: size.height*.015,),
                    TextButtonWidget(text: "Iniciar sesión", color: ColorPalette.colorPrincipal, fontSize: 16, function: (){})
                  ],
                  ),
                
                  
                )),
          )),
    );
  }
}
