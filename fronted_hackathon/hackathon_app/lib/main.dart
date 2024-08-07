import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_app/app_core/iservices/ianimal_healt_calendar_services.dart';
import 'package:hackathon_app/app_core/iservices/icattle_services.dart';
import 'package:hackathon_app/app_core/iservices/icow_calving_services.dart';
import 'package:hackathon_app/app_core/iservices/idocument_services.dart';
import 'package:hackathon_app/app_core/iservices/iinsemination_services.dart';
import 'package:hackathon_app/app_core/iservices/imeditation_services.dart';
import 'package:hackathon_app/app_core/iservices/iphysical_problem_services.dart';
import 'package:hackathon_app/app_core/iservices/itreatment_service.dart';
import 'package:hackathon_app/app_core/services/animal_healt_calendar_services.dart';
import 'package:hackathon_app/app_core/services/cattle_services.dart';
import 'package:hackathon_app/app_core/services/cow_calving_services.dart';
import 'package:hackathon_app/app_core/services/document_services.dart';
import 'package:hackathon_app/app_core/services/insemination_services.dart';
import 'package:hackathon_app/app_core/services/meditation_services.dart';
import 'package:hackathon_app/app_core/services/physical_problems_services.dart';
import 'package:hackathon_app/app_core/services/shared_preferences_services.dart';
import 'package:hackathon_app/app_core/services/treatment_services.dart';
import 'package:hackathon_app/domain/interfaces/document_model.dart';
import 'package:hackathon_app/domain/interfaces/ianimal_health_calendar_model.dart';
import 'package:hackathon_app/domain/interfaces/icattle_model.dart';
import 'package:hackathon_app/domain/interfaces/icow_calving_model.dart';
import 'package:hackathon_app/domain/interfaces/iinsermination_model.dart';
import 'package:hackathon_app/domain/interfaces/imeditation_model.dart';
import 'package:hackathon_app/domain/interfaces/iphysical_problem_model.dart';
import 'package:hackathon_app/domain/interfaces/itreatment.dart';
import 'package:hackathon_app/domain/models/Entities/cattle.dart';
import 'package:hackathon_app/domain/models/Entities/user.dart';
import 'package:hackathon_app/infraestructure/repository/animal_healt_calendar_repository.dart';
import 'package:hackathon_app/infraestructure/repository/cattle_repository.dart';
import 'package:hackathon_app/infraestructure/repository/cow_calving_repository.dart';
import 'package:hackathon_app/infraestructure/repository/document_repository.dart';
import 'package:hackathon_app/infraestructure/repository/insemination_repository.dart';
import 'package:hackathon_app/infraestructure/repository/meditation_repository.dart';
import 'package:hackathon_app/infraestructure/repository/physical_problem_repository.dart';
import 'package:hackathon_app/infraestructure/repository/treatment_repository.dart';
import 'package:hackathon_app/infraestructure/repository/user_repository_db.dart';
import 'package:hackathon_app/provider/animal_healt_calendar_provider.dart';
import 'package:hackathon_app/provider/body_part_provider.dart';
import 'package:hackathon_app/provider/cattle_provider.dart';
import 'package:hackathon_app/provider/cow_calving_provider.dart';
import 'package:hackathon_app/provider/document_provider.dart';
import 'package:hackathon_app/provider/insemination_provider.dart';
import 'package:hackathon_app/provider/meditation_provider.dart';
import 'package:hackathon_app/provider/physical_problem_provider.dart';
import 'package:hackathon_app/provider/treatment_provider.dart';
import 'package:hackathon_app/ui/pages/mobil/add_cow_page.dart';
import 'package:hackathon_app/ui/pages/mobil/add_detail_physical_page.dart';
import 'package:hackathon_app/ui/pages/mobil/calendar_page.dart';
import 'package:hackathon_app/ui/pages/mobil/cattle_page.dart';
import 'package:hackathon_app/ui/pages/mobil/change_account_page.dart';
import 'package:hackathon_app/ui/pages/mobil/cow_information_page.dart';
import 'package:hackathon_app/ui/pages/mobil/cow_page.dart';
import 'package:hackathon_app/ui/pages/mobil/farm_page.dart';
import 'package:hackathon_app/ui/pages/mobil/principal_page.dart';

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

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  MyApp({
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
              iUserModel: Provider.of<IUserModel>(context, listen: false),
              iModel: UserRepositoryDB()),
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
        ),
        Provider<ICattleModel>(create: (_) => CattleRepository()),
        Provider<ICattleServices>(
            create: (context) => CattleServices(
                iCattleModel:
                    Provider.of<ICattleModel>(context, listen: false))),
        ChangeNotifierProvider(
          create: (context) => CattleProvider(
              iCattleServices:
                  Provider.of<ICattleServices>(context, listen: false)),
        ),
        Provider<ITreatmentModel>(create: (_) => TreatmentRepository()),
        Provider<ITreatmentServices>(
            create: (context) => TreatmentServices(
                iTreatmentModel:
                    Provider.of<ITreatmentModel>(context, listen: false))),
        ChangeNotifierProvider(
          create: (context) => TreatmentProvider(
              iTreatmentServices:
                  Provider.of<ITreatmentServices>(context, listen: false)),
        ),
        Provider<IMeditationModel>(create: (_) => MeditationRepository()),
        Provider<IMeditationServices>(
            create: (context) => MeditationServices(
                iMeditationModel:
                    Provider.of<IMeditationModel>(context, listen: false))),
        ChangeNotifierProvider(
          create: (context) => MeditationProvider(
              iFarmServices:
                  Provider.of<IMeditationServices>(context, listen: false)),
        ),
        ChangeNotifierProvider(create: (_) => BodyPartProvider()),
        Provider<IPhysicalProblemModel>(
            create: (_) => PhysicalProblemRepository()),
        Provider<IPhysicalProblemServices>(
            create: (context) => PhysicalProblemsServices(
                iPhysicalProblemModel: Provider.of<IPhysicalProblemModel>(
                    context,
                    listen: false))),
        ChangeNotifierProvider(
          create: (context) => PhysicalProblemProvider(
              iPhysicalProblemServices: Provider.of<IPhysicalProblemServices>(
                  context,
                  listen: false)),
        ),
        Provider<IAnimalHealtCalendarModel>(
            create: (_) => AnimalHealtCalendarRepository()),
        Provider<IAnimalHealtCalendarServices>(
            create: (context) => AnimalHeartCalendarServices(
                iAnimalHealtCalendarModel:
                    Provider.of<IAnimalHealtCalendarModel>(context,
                        listen: false))),
        ChangeNotifierProvider(
          create: (context) => AnimalHealtCalendarProvider(
              iAnimalHealtCalendarServices:
                  Provider.of<IAnimalHealtCalendarServices>(context,
                      listen: false)),
        ),
        Provider<IInseminationModel>(create: (_) => InseminationRepository()),
        Provider<IInseminationServices>(
            create: (context) => InseminationServices(
                iInseminationModel:
                    Provider.of<IInseminationModel>(context, listen: false))),
        ChangeNotifierProvider(
          create: (context) => InseminationProvider(
              inseminationServices:
                  Provider.of<IInseminationServices>(context, listen: false)),
        ),
        Provider<ICowCalvingModel>(create: (_) => CowCalvingRepository()),
        Provider<ICowCalvingServices>(
            create: (context) => CowCalvingServices(
                iCowCalvingModel:
                    Provider.of<ICowCalvingModel>(context, listen: false))),
        ChangeNotifierProvider(
          create: (context) => CowCalvingProvider(
              iCowCalvingServices:
                  Provider.of<ICowCalvingServices>(context, listen: false)),
        ),
        Provider<IDocumentModel>(create: (_) => DocumentoRepository()),
        Provider<IDocumentServices>(
            create: (context) => DocumentServices(
                iDocumentModel:
                    Provider.of<IDocumentModel>(context, listen: false))),
        ChangeNotifierProvider(
          create: (context) => DocumentProvider(
              iDocumentServices:
                  Provider.of<IDocumentServices>(context, listen: false)),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: {"/": (context) => SplashScreen()},

        // darkTheme: ThemeData(
        //   primaryColor: ColorPalette.colorPrincipal,
        //     scaffoldBackgroundColor: Colors.black87,
        //       colorScheme: ColorScheme.light(primary: ColorPalette.colorPrincipal),
        //       fontFamily: "Montserrat",

        // ),
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

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FlutterSplashScreen.fadeIn(
        backgroundColor: Colors.white,
        onInit: () {
          debugPrint("On Init");
        },
        onEnd: () {
          debugPrint("On End");
        },
        childWidget: SizedBox(
          height: 200,
          width: 200,
          child: Image.asset("assets/images/sections/Logo.png"),
        ),
        onAnimationEnd: () => debugPrint("On Fade In End"),
        defaultNextScreen: null,
        setNextScreenAsyncCallback: () async {
          final userProvider =
              Provider.of<UserProvider>(context, listen: false);

          User? user = await SharedPreferencesServices.readUser();
          if (user != null) {
            userProvider.user = user;
            return PrincipalPage(
              IdUsuario: user.userId!,
            );
          } else {
            int count = (await userProvider.readUser()).length;
            if (count > 0) {
              return ChangeAccountPage();
            }
            return InitialPage();
          }
        },
        // defaultNextScreen: CalendarPage(CattleId: "ddd",)
      ),
    );
  }
}
