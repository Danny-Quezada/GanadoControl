import 'package:flutter/material.dart';
import 'package:hackathon_app/ui/pages/mobil/configuration_page.dart';
import 'package:hackathon_app/ui/pages/mobil/farm_page.dart';
import 'package:hackathon_app/ui/pages/mobil/inta_page.dart';

class PrincipalPage extends StatefulWidget {
  const PrincipalPage({super.key});

  @override
  State<PrincipalPage> createState() => _PrincipalPageState();
}

List<Widget> pages = [Container(), FarmPage(), IntaPage(), ConfigurationPage()];
int _index = 0;

class _PrincipalPageState extends State<PrincipalPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: pages[_index],
        bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              setState(() {
                _index = value;
              });
            },
            currentIndex: _index,
            elevation: 0,
            iconSize: 32,
            items: [
              BottomNavigationBarItem(
                  backgroundColor: Colors.white,
                  label: "",
                  icon: Image.asset(
                    "assets/images/icons/Charts-inactived.png",
                    width: 36,
                    height: 36,
                  ),
                  activeIcon: Image.asset(
                    "assets/images/icons/Charts-active.png",
                    width: 36,
                    height: 36,
                  )),
              BottomNavigationBarItem(
                  label: "",
                  backgroundColor: Colors.white,
                  icon: Image.asset(
                    "assets/images/icons/Cows-inactived.png",
                    width: 36,
                    height: 36,
                  ),
                  activeIcon: Image.asset(
                    "assets/images/icons/Cows-active.png",
                    width: 36,
                    height: 36,
                  )),
              BottomNavigationBarItem(
                  backgroundColor: Colors.white,
                  label: "",
                  icon: Image.asset(
                    "assets/images/icons/News-inactived.png",
                    width: 36,
                    height: 36,
                  ),
                  activeIcon: Image.asset(
                    "assets/images/icons/News-active.png",
                    width: 36,
                    height: 36,
                  )),
              BottomNavigationBarItem(
                  backgroundColor: Colors.white,
                  label: "",
                  icon: Image.asset(
                    "assets/images/icons/Configuration-inactive.png",
                    width: 36,
                    height: 36,
                  ),
                  activeIcon: Image.asset(
                    "assets/images/icons/Configuration-active.png",
                    width: 36,
                    height: 36,
                  )),
            ]),
      ),
    );
  }
}
