import 'package:flutter/material.dart';
import 'package:flutter_provider_utilities/flutter_provider_utilities.dart';
import 'package:hackathon_app/app_core/services/shared_preferences_services.dart';
import 'package:hackathon_app/provider/user_provider.dart';
import 'package:hackathon_app/ui/config/color_palette.dart';
import 'package:hackathon_app/ui/pages/mobil/initial_page.dart';
import 'package:hackathon_app/ui/pages/mobil/principal_page.dart';
import 'package:hackathon_app/ui/widgets/flushbar_widget.dart';
import 'package:provider/provider.dart';

class ChangeAccountPage extends StatelessWidget {
  const ChangeAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "Cuentas en el dispositivo",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                  builder: (context) {
                    return InitialPage();
                  },
                ), (route) => false);
              },
              icon: Icon(
                Icons.home,
                color: ColorPalette.colorPrincipal,
              ))
        ],
      ),
      body: Center(
        child: MessageListener<UserProvider>(
          showError: (error) {
            flushbarWidget(
                context: context, title: "Error", message: error, error: true);
          },
          showInfo: (info) {},
          child: FutureBuilder(
            future: userProvider.readUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        onTap: () {
                          userProvider.user = snapshot.data![index];
                          SharedPreferencesServices.saveUser(
                              snapshot.data![index]);
                          if (userProvider.user != null) {
                            principalPage(context);
                          }
                        },
                        title: Text(
                          snapshot.data![index].userName,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          snapshot.data![index].workstation,
                          style: TextStyle(color: Colors.grey.shade400),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                      );
                    },
                  );
                }
              }
              return Container();
            },
          ),
        ),
      ),
    ));
  }

  void principalPage(context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const PrincipalPage()),
        (route) => false);
  }
}
