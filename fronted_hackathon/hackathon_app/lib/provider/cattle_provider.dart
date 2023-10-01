import 'package:flutter/material.dart';
import 'package:flutter_provider_utilities/flutter_provider_utilities.dart';
import 'package:hackathon_app/app_core/iservices/icattle_services.dart';
import 'package:hackathon_app/domain/models/Entities/cattle.dart';
import 'package:hackathon_app/provider/igeneric_provider.dart';

class CattleProvider extends ChangeNotifier
    with IGenericProvider<Cattle>, MessageNotifierMixin {
  @override
  void doNull() {
    t = null;
    list = null;
  }

  ICattleServices _iCattleServices;

  CattleProvider({required ICattleServices iCattleServices})
      : _iCattleServices = iCattleServices;

  Future<void> create(Cattle cattle) async {
    try {
      int cattleValue = await _iCattleServices.create(cattle);

      if (cattleValue >= 0) {
        cattle.idCattle = cattleValue as String;
        t = cattle;
        list!.add(t!);
        t = null;
        notifyInfo("Vaca con id: ${cattle.idCattle} creado");
      }
    } catch (e) {
      notifyError("Error en el servidor");
    }
    notifyListeners();
  }

  Future<List<Cattle>> getAllCattleByFarm(int gropId) async {
    if (list != null) {
      return list!;
    }

    list = await _iCattleServices.getAllCattleByGroup(gropId);
    notifyListeners();
    return list!;
  }
}