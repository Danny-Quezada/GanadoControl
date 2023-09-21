import 'package:flutter/material.dart';
import 'package:hackathon_app/ui/config/color_palette.dart';
import 'package:hackathon_app/ui/pages/mobil/login_page.dart';
import 'package:hackathon_app/ui/widgets/button_widget.dart';
import 'package:hackathon_app/ui/widgets/text_button_widget.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.08,
            ),
            Image.asset(
              'assets/images/sections/Logo.png',
              width: 450,
              height: 363,
            ),
            SizedBox(
              height: size.height * 0.13,
            ),
            ButtonWidget(
                text: 'Registrarse',
                size: const Size(284, 63),
                color: ColorPalette.colorPrincipal,
                rounded: 25,
                function: () => sigInPage(),
                fontSize: 24),
            SizedBox(
              height: size.height * 0.04,
            ),
            TextButtonWidget(
                text: 'Iniciar sesión',
                color: ColorPalette.colorPrincipal,
                fontSize: 24,
                function: () => LoginPage())
          ],
        ),
      ),
    );
  }

  void sigInPage() {}

  void logInPage() {}
}
