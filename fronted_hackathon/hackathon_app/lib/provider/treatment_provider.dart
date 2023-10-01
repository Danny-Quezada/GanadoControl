import 'package:flutter/material.dart';
import 'package:flutter_provider_utilities/flutter_provider_utilities.dart';
import 'package:hackathon_app/app_core/iservices/itreatment_service.dart';
import 'package:hackathon_app/domain/models/Entities/treatment.dart';
import 'package:hackathon_app/provider/igeneric_provider.dart';

class TreatmentProvider extends ChangeNotifier
    with IGenericProvider<Treatment>, MessageNotifierMixin {
  @override
  void doNull() {
    t = null;
    list = null;
  }

  ITreatmentServices _iTreatmentServices;

  TreatmentProvider({required ITreatmentServices iTreatmentServices})
      : _iTreatmentServices = iTreatmentServices;

  Future<void> create(Treatment treatment) async {
    try {
      int treatmentValue = await _iTreatmentServices.create(treatment);

      if (treatmentValue >= 0) {
        t = treatment;
        list!.add(t!);
        t = null;
        notifyInfo(
            "Tratamiento para la vaca con id: ${treatment.cattleId} creado");
      }
    } catch (e) {
      notifyError("Error en el servidor");
    }
    notifyListeners();
  }

  Future<List<Treatment>> getAllTreatmentByFarm(int farmId) async {
    if (list != null) {
      return list!;
    }

    list = await _iTreatmentServices.getAllTreatmentByFarm(farmId);
    notifyListeners();
    return list!;
  }
}
