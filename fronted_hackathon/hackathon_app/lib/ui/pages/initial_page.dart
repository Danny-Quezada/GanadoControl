import 'package:flutter/material.dart';

import '../config/color_palette.dart';
import '../widgets/button_widget.dart';
import '../widgets/text_button_widget.dart';
import 'login_page.dart';
import 'sign_in_page.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
       
          body: Center(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * .1,
                ),
                Image.asset(
                  'assets/images/sections/Logo.png',
                  width: 350,
                  height: 238.89,
                ),
                SizedBox(
                  height: size.height * .25,
                ),
                ButtonWidget(
                  text: "Registrarse",
                  size: const Size(268, 57),
                  color: ColorPalette.colorPrincipal,
                  rounded: 25,
                  function: () => signInPage(context),
                  fontSize: 16,
                ),
                SizedBox(
                  height: size.height * .02,
                ),
                TextButtonWidget(
                    text: "Iniciar sesión",
                    color: ColorPalette.colorPrincipal,
                    fontSize: 16,
                    function: () => loginPage(context)),
              ],
            ),
          )),
    );
  }

  void signInPage(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return SignInPage();
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve=Curves.ease;
          var tween=Tween(begin: begin,end:  end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  void loginPage(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return LoginPage();
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(-1,0);
          const end = Offset(0, 0);
          const curve=Curves.ease;
          var tween=Tween(begin: begin,end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }
}
