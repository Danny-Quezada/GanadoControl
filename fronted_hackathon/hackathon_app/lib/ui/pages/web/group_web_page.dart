import 'package:flutter/material.dart';
import 'package:hackathon_app/ui/pages/web/cow_web_page.dart';
import 'package:hackathon_app/ui/pages/web/inventary_page.dart';
import 'package:hackathon_app/ui/widgets/custom_card_widget.dart';

class GroupWebPage extends StatelessWidget {
  const GroupWebPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: const Center(
          child: Text(
            'Grupos',
            style: TextStyle(color: Colors.black),
          ),
        ),
        actions: const [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
                'https://upload.wikimedia.org/wikipedia/commons/3/3c/Tom_Holland_by_Gage_Skidmore.jpg'),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    height: 35,
                    child: const SearchBar(
                      elevation: MaterialStatePropertyAll<double?>(0),
                      leading: Icon(
                        Icons.search,
                        color: Color(0xffABA5A5),
                      ),
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Color(0xFFf2f2f2)),
                    )),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.0005),
                  child: TextButton(
                      style: const ButtonStyle(
                          splashFactory: NoSplash.splashFactory),
                      onPressed: () {},
                      child: GestureDetector(
                        onTap: () => inventoryWebPage(context),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/icons/inventory.png",
                              width: 36,
                              height: 36,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              "Inventario",
                              style: TextStyle(
                                  color: Color(0xFFCA78FF),
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            buildGrip(),
          ],
        ),
      ),
    );
  }

  Widget buildGrip() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 2.0,
          childAspectRatio: 1.6,
          mainAxisExtent: 130),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: CustomCardWdiget(null, function: () {
            cowWebPage(context, index);
          },
              urlImage: "",
              title: "Grupo 1",
              description: "Numero de vacas 2",
              radius: 12),
        );
      },
    );
  }

  void inventoryWebPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return const InventoryWebPage();
      },
    ));
  }

  void cowWebPage(BuildContext context, int idCastle) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return CowWebPage(idCastle: idCastle);
      },
    ));
  }
}
