import 'package:flutter/material.dart';
import 'package:flutter_provider_utilities/flutter_provider_utilities.dart';
import 'package:hackathon_app/app_core/iservices/icattle_services.dart';
import 'package:hackathon_app/domain/models/Entities/cattle.dart';
import 'package:hackathon_app/provider/igeneric_provider.dart';

class CattleProvider extends ChangeNotifier
    with IGenericProvider<Cattle>, MessageNotifierMixin {
  ICattleServices _iCattleServices;

  CattleProvider({required ICattleServices iCattleServices})
      : _iCattleServices = iCattleServices;

  Future<void> create(Cattle cattle) async {
    try {
      String cattleValue = await _iCattleServices.createCattle(cattle);
      if (cattleValue.isNotEmpty) {
        cattle.idCattle = cattleValue;
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

  Future<List<Cattle>> getAllCattleByGroup(int gropId) async {
    if (list != null) {
      return list!;
    }

    list = await _iCattleServices.getAllCattleByGroup(gropId);
    notifyListeners();
    return list!;
  }

  find(String text) {
    if (text.isEmpty) {
      searchList = null;
    } else {
      searchList = list!
          .where((element) =>
              element.idCattle.toLowerCase().contains(text.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  Future<Cattle?> getCattleById(String cattleId) async {
    try {
      return await _iCattleServices.getCattle(cattleId);
    } catch (e) {
      notifyError(error);
      return null;
    }
  }

  Future<List<BarDataPoint>> getGraphicsByCattle(int IdUsuario) async {
    Map<String, dynamic> responseBody =
        await _iCattleServices.getGraphicsByCatlle(IdUsuario);
    if (responseBody.isEmpty ||
        responseBody['data'] == null ||
        responseBody['data'].isEmpty) {
      return [BarDataPoint("Toro", 0), BarDataPoint("Vaca", 0)];
    }

    return [
      BarDataPoint("Toro", responseBody['noVacunadosT']),
      BarDataPoint("Vaca", responseBody['noVacunadosV'])
    ];
  }
}

class BarDataPoint {
  final String categoria;
  final double valor;

  BarDataPoint(this.categoria, this.valor);
}
