import 'package:flutter/material.dart';

import 'package:hackathon_app/domain/models/Entities/physical_problem.dart';
import 'package:hackathon_app/provider/body_part_provider.dart';
import 'package:hackathon_app/provider/physical_problem_provider.dart';
import 'package:hackathon_app/ui/config/color_palette.dart';

import 'package:hackathon_app/ui/widgets/cow_part_widget.dart';

import 'package:provider/provider.dart';

class AddDetailCowPage extends StatelessWidget {
  String cattleId;
  AddDetailCowPage({required this.cattleId});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var physicalProblemsProvider =
        Provider.of<PhysicalProblemProvider>(context, listen: false);
    final bodyPartProvider =
        Provider.of<BodyPartProvider>(context, listen: false);

    bodyPartProvider.cattleId = cattleId;
    return SafeArea(
        child: Scaffold(
      floatingActionButton: Consumer<BodyPartProvider>(
        builder: (context, value, child) {
          if (value.physicalProblems.isEmpty) {
            return Container();
          } else {
            return FloatingActionButton.extended(
              elevation: 1,
              onPressed: () async {
                for (int i = 0;
                    i < bodyPartProvider.physicalProblems.length;
                    i++) {
                  await physicalProblemsProvider
                      .create(bodyPartProvider.physicalProblems[i]);
                }
              },
              label: Text(
                "Agregar",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: ColorPalette.colorPrincipal,
            );
          }
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CowPartWidget(),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: const Text(
                "Partes con problema",
                style: TextStyle(
                    fontFamily: "Karla",
                    fontSize: 20,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
                width: size.width,
                height: (size.height * .6),
                child: PhysicalProblemList(
                  cattleId: cattleId,
                ))
          ],
        ),
      ),
    ));
  }
}

class PhysicalProblemList extends StatelessWidget {
  String cattleId;
  PhysicalProblemList({required this.cattleId});

  @override
  Widget build(BuildContext context) {
    return Consumer<BodyPartProvider>(
      builder: (context, value, child) {
        return ListView.separated(
          padding: const EdgeInsets.all(15),
          separatorBuilder: (context, index) => SizedBox(
            height: 50,
          ),
          itemCount: value.physicalProblems.length,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value.physicalProblems[index].partName),
                TextField(
                  onChanged: (valueT) {
                    value.physicalProblems[index].description = valueT;
                  },
                  decoration: InputDecoration(
                      hintText: "Observaciones",
                      hintStyle: TextStyle(color: Colors.grey.shade300)),
                )
              ],
            );
          },
        );
      },
    );
  }
}
