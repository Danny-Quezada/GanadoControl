import 'package:flutter/material.dart';
import 'package:hackathon_app/app_core/iservices/ifarm_services.dart';
import 'package:hackathon_app/app_core/services/farm_services.dart';
import 'package:hackathon_app/domain/interfaces/ifarm_model.dart';
import 'package:hackathon_app/domain/interfaces/iuser_model.dart';
import 'package:hackathon_app/infraestructure/repository/farm_repository.dart';
import 'package:hackathon_app/infraestructure/repository/user_repository.dart';
import 'package:hackathon_app/provider/farm_provider.dart';
import 'package:hackathon_app/ui/config/color_palette.dart';
import 'package:hackathon_app/ui/pages/web/initial_web_page.dart';
import 'package:provider/provider.dart';

import 'app_core/iservices/iuser_services.dart';
import 'app_core/services/user_services.dart';
import 'provider/user_provider.dart';
import 'ui/pages/mobil/initial_page.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<IUserModel>(
          create: (_) =>
              UserRepository(), // Crea una instancia de UserRepository como IUserModel
        ),
        Provider<IUserServices>(
          create: (context) => UserServices(
              iUserModel: Provider.of<IUserModel>(context, listen: false)),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(
              iUserServices:
                  Provider.of<IUserServices>(context, listen: false)),
        ),
        Provider<IFarmModel>(create: (_) => FarmRepository()),
        Provider<IFarmServices>(
            create: (context) => FarmServices(
                ifarmModel: Provider.of<IFarmModel>(context, listen: false))),
        ChangeNotifierProvider(
          create: (context) => FarmProvider(
              iFarmServices:
                  Provider.of<IFarmServices>(context, listen: false)),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: {"/": (_) => const InitialWebPage()},
        theme: ThemeData(
          primaryColor: ColorPalette.colorPrincipal,
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme.light(primary: ColorPalette.colorPrincipal),
          fontFamily: "Montserrat",
        ),
      ),
    );
  }
}
