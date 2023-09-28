import 'package:flutter/material.dart';
import 'package:hackathon_app/ui/pages/web/farm_web_page.dart';

class PrincipalPageWeb extends StatefulWidget {
  const PrincipalPageWeb({Key? key}) : super(key: key);

  @override
  State<PrincipalPageWeb> createState() => _PrincipalPageWebState();
}

class _PrincipalPageWebState extends State<PrincipalPageWeb> {
  int _index = 0;

  void _changeIcons(int index) {
    setState(() {
      _index = index;
    });
  }

  List<String> get ruteImage {
    if (_index == 0) {
      return [
        'assets/images/icons/Charts-active.png',
        'assets/images/icons/Cows-inactived.png',
        'assets/images/icons/News-inactived.png',
        'assets/images/icons/Configuration-inactive.png',
      ];
    } else if (_index == 1) {
      return [
        'assets/images/icons/Charts-inactived.png',
        'assets/images/icons/Cows-active.png',
        'assets/images/icons/News-inactived.png',
        'assets/images/icons/Configuration-inactive.png',
      ];
    } else if (_index == 2) {
      return [
        'assets/images/icons/Charts-inactived.png',
        'assets/images/icons/Cows-inactived.png',
        'assets/images/icons/News-active.png',
        'assets/images/icons/Configuration-inactive.png',
      ];
    } else if (_index == 3) {
      return [
        'assets/images/icons/Charts-inactived.png',
        'assets/images/icons/Cows-inactived.png',
        'assets/images/icons/News-inactived.png',
        'assets/images/icons/Configuration-active.png',
      ];
    }
    return [];
  }

  List<Widget> get pages {
    return [
      Container(
        child: const Text('Pagina principal'),
      ),
      FarmWebPage(),
      Container(
        child: const Text('Pagina noticias'),
      ),
      Container(
        child: const Text('Pagina configuracion'),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: 100,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: SizedBox(
                    width: size.width / 4,
                    height: 20,
                    child: IconButton(
                      onPressed: () => _changeIcons(0),
                      icon: Image.asset(
                        ruteImage[0],
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: size.width / 4,
                    height: 20,
                    child: IconButton(
                      onPressed: () => _changeIcons(1),
                      icon: Image.asset(
                        ruteImage[1],
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: size.width / 4,
                    height: 20,
                    child: IconButton(
                      onPressed: () => _changeIcons(2),
                      icon: Image.asset(
                        ruteImage[2],
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: size.width / 4,
                    height: 20,
                    child: Center(
                      child: IconButton(
                        onPressed: () => _changeIcons(3),
                        icon: Image.asset(
                          ruteImage[3],
                          width: 60,
                          height: 60,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: pages[_index],
          ),
        ],
      ),
    );
  }
}
