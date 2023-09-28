import 'package:flutter/material.dart';
import 'package:hackathon_app/ui/config/color_palette.dart';
import 'package:hackathon_app/ui/pages/web/log_in_web_page.dart';
import 'package:hackathon_app/ui/pages/web/sig_in_web_page.dart';
import 'package:hackathon_app/ui/widgets/button_widget.dart';
import 'package:hackathon_app/ui/widgets/text_button_widget.dart';

class InitialWebPage extends StatelessWidget {
  const InitialWebPage({super.key});

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
                function: () => sigInPage(context),
                fontSize: 24),
            SizedBox(
              height: size.height * 0.04,
            ),
            TextButtonWidget(
                text: 'Iniciar sesión',
                color: ColorPalette.colorPrincipal,
                fontSize: 24,
                function: () => logInPage(context))
          ],
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
}
