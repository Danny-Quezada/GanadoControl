import 'package:flutter/material.dart';
import 'package:flutter_provider_utilities/flutter_provider_utilities.dart';
import 'package:hackathon_app/app_core/iservices/ifarm_services.dart';
import 'package:hackathon_app/domain/models/Entities/farm.dart';
import 'package:hackathon_app/provider/igeneric_provider.dart';

class FarmProvider extends ChangeNotifier
    with IGenericProvider<Farm>, MessageNotifierMixin {
  @override
  void doNull() {
    // TODO: implement doNull
    token = null;
    role = "Visitante";
    super.doNull();
  }

  IFarmServices _iFarmServices;
  String? token;
  bool refresh = false;
  FarmProvider({required IFarmServices iFarmServices})
      : _iFarmServices = iFarmServices;

  Future<void> create(Farm farmU) async {
    try {
      int farmValue = await _iFarmServices.create(farmU);
      if (farmValue >= 0) {
        farmU.farmId = farmValue;
        t = farmU;
        list!.add(t!);
        t = null;
        notifyInfo("finca: ${farmU.farmName} creada");
      }
    } catch (e) {
      notifyError("Error en el servidor");
    }
    notifyListeners();
  }

  Future<List<Farm>> getAllFarmByUserId(int userId) async {
    if (!refresh) {
      if (list != null) {
        return list!;
      }
    }
    list = await _iFarmServices.getAllFarmByUser(userId);

    notifyListeners();
    return list!;
  }

  changeSelect(int index) {
    bool select = !(list![index].isSelected!);
    list![index].isSelected = select;
    if (select) {
      selectedQuantity++;
    } else {
      selectedQuantity--;
    }

    notifyListeners();
  }

  find(String text) {
    if (text.isEmpty) {
      searchList = null;
    } else {
      searchList = list!
          .where((element) =>
              element.farmName.toLowerCase().contains(text.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  String role = "Visitante";
  Future<void> inviteToFarm(int farmId, String role, int userId) async {
    try {
      token = await _iFarmServices.inviteToFarm(farmId, role, userId);
      notifyListeners();
    } catch (e) {
      notifyError(e);
    }
  }
  Future<int> joinFarm(String token, int userId)async{
    try{
      return await _iFarmServices.joinFarm(token, userId);
    }
    catch(e){
      notifyError("Error en el servidor");
      return -1;
    }
  }
}
