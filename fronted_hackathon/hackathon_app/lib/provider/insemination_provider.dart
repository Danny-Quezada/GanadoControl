import 'package:flutter/material.dart';
import 'package:flutter_provider_utilities/flutter_provider_utilities.dart';
import 'package:hackathon_app/app_core/iservices/iinsemination_services.dart';
import 'package:hackathon_app/domain/models/Entities/insemination.dart';
import 'package:hackathon_app/provider/igeneric_provider.dart';

class InseminationProvider extends ChangeNotifier
    with IGenericProvider<Insemination>, MessageNotifierMixin {
  @override
  void doNull() {
    t = null;
    list = null;
  }

  IInseminationServices _iInseminationServices;

  InseminationProvider({required IInseminationServices inseminationServices})
      : _iInseminationServices = inseminationServices;

  Future<void> create(Insemination insemination) async {
    try {
      int inseminationValue = await _iInseminationServices.create(insemination);

      if (inseminationValue >= 0) {
        t = insemination;
        list!.add(t!);
        t = null;
        notifyInfo(
            "La inseminacion para la vaca con id: ${insemination.cattleId} creado");
      }
    } catch (e) {
      notifyError("Error en el servidor");
    }
    notifyListeners();
  }
}
