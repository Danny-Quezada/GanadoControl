import 'package:flutter/material.dart';
import 'package:hackathon_app/domain/models/Entities/meditation.dart';
import 'package:hackathon_app/domain/models/enums/pharmaceuticals.dart';
import 'package:hackathon_app/provider/meditation_provider.dart';
import 'package:hackathon_app/ui/config/color_palette.dart';
import 'package:hackathon_app/ui/pages/mobil/add_pharmaceutical_page.dart';
import 'package:hackathon_app/ui/pages/mobil/cow_page.dart';
import 'package:hackathon_app/ui/widgets/pills_widget.dart';
import 'package:hackathon_app/ui/widgets/rich_text_widget.dart';
import 'package:hackathon_app/ui/widgets/search_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class InventaryPage extends StatelessWidget {
  TextEditingController _controller = TextEditingController();
  int farmId;
  InventaryPage({required this.farmId});

  @override
  Widget build(BuildContext context) {
    final meditationProvider =
        Provider.of<MeditationProvider>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return AddPharmaceuticalPage(farmId: farmId);
                },
              ));
            }),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
          child: Column(
            children: [
              searchBar(
                  function: (value) {
                    meditationProvider.find(value);
                  },
                  controller: _controller,
                  height: 35,
                  padding: 16,
                  iconColor: const Color(0xffABA5A5),
                  backgroundColor: const Color(0xFFf2f2f2)),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: size.height * .9,
                width: size.width,
                child: pharmaceuticalList(farmId: farmId),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class pharmaceuticalList extends StatelessWidget {
  int farmId;
  pharmaceuticalList({
    required this.farmId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final meditationProvider =
        Provider.of<MeditationProvider>(context, listen: false);
    meditationProvider.getAllFarmByUserId(farmId);
    return Consumer<MeditationProvider>(
      builder: (context, value, child) {
        if (value.list == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.only(left: 20, right: 20),
          separatorBuilder: (context, index) => SizedBox(
            height: 20,
          ),
          itemCount: value.searchList == null
              ? value.list!.length
              : value.searchList!.length,
          itemBuilder: (BuildContext context, int index) {
            int quantity = value.searchList == null
                ? value.list![index].quantity
                : value.searchList![index].quantity;
            Pharmaceuticals pharmaceuticals = value.searchList == null
                ? Pharmaceuticals.values.firstWhere(
                    (element) => element.name == value.list![index].type)
                : Pharmaceuticals.values.firstWhere(
                    (element) => element.name == value.searchList![index].type);
            String title = value.searchList == null
                ? value.list![index].meditationName
                : value.searchList![index].meditationName;
            return PillWidget(quantity,
                pharmaceuticals: pharmaceuticals, title: title, function: () {
              _showDetailsPharmaceutical(
                  value.searchList == null
                      ? value.list![index]
                      : value.searchList![index],
                  context);
            });
          },
        );
      },
    );
  }

  _showDetailsPharmaceutical(Meditation meditation, BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(meditation.meditationName),
              RichTextWidget(
                  title: "Fecha de caducidad: ",
                  content: DateFormat('hh:mm:ss')
                      .format(meditation.expirationDate!)),
              RichTextWidget(
                  title: "Fecha de entrega: ",
                  content:
                      DateFormat('hh:mm:ss').format(meditation.deliveryDate!)),
              RichTextWidget(title: "Precio: ", content: meditation.price),
              RichTextWidget(
                  title: "Cantidad: ", content: meditation.quantity.toString()),
            ],
          ),
        );
      },
    );
  }
}
