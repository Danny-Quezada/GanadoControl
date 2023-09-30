
import 'package:flutter/material.dart';


import 'package:provider/provider.dart';

import 'app_core/iservices/ifarm_services.dart';
import 'app_core/iservices/iflock_services.dart';
import 'app_core/iservices/iuser_services.dart';
import 'app_core/services/farm_services.dart';
import 'app_core/services/flock_services.dart';
import 'app_core/services/user_services.dart';
import 'domain/interfaces/ifarm_model.dart';
import 'domain/interfaces/iflock_model.dart';
import 'domain/interfaces/iuser_model.dart';
import 'infraestructure/repository/farm_repository.dart';
import 'infraestructure/repository/flock_repository.dart';
import 'infraestructure/repository/user_repository.dart';
import 'provider/farm_provider.dart';
import 'provider/flock_provider.dart';
import 'provider/user_provider.dart';
import 'ui/config/color_palette.dart';
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
        ),

 Provider<IFlockModel>(create: (_) => FlockRepository()),
        Provider<IFlockServices>(
            create: (context) => FlockServices(
                iFlockModel: Provider.of<IFlockModel>(context, listen: false))),
        ChangeNotifierProvider(
          create: (context) => FlockProvider(
              iFlockServices: 
                  Provider.of<IFlockServices>(context, listen: false)),
        )

        
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: {"/":(context)=>InitialPage()},
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

