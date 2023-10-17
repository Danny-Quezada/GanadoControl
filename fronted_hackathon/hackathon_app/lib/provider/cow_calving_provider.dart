import 'package:flutter/material.dart';
import 'package:flutter_provider_utilities/flutter_provider_utilities.dart';
import 'package:hackathon_app/app_core/iservices/icow_calving_services.dart';
import 'package:hackathon_app/domain/models/Entities/cow_calving.dart';
import 'package:hackathon_app/provider/igeneric_provider.dart';

class CowCalvingProvider extends ChangeNotifier
    with IGenericProvider<CowCalving>, MessageNotifierMixin {
  @override
  void doNull() {
    t = null;
    list = null;
  }

  ICowCalvingServices _cowCalvingServices;

  CowCalvingProvider({required ICowCalvingServices iCowCalvingServices})
      : _cowCalvingServices = iCowCalvingServices;

  Future<void> create(CowCalving cowCalving) async {
    try {
      int treatmentValue = await _cowCalvingServices.create(cowCalving);

      if (treatmentValue >= 0) {
        t = cowCalving;
        list!.add(t!);
        t = null;
        notifyInfo("Parto para la vaca con id: ${cowCalving.cattleId} creado");
      }
    } catch (e) {
      notifyError("Error en el servidor");
    }
    notifyListeners();
  }
}
