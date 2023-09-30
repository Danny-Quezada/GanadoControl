import 'package:flutter/material.dart';
import 'package:flutter_provider_utilities/flutter_provider_utilities.dart';
import 'package:hackathon_app/app_core/iservices/ifarm_services.dart';
import 'package:hackathon_app/domain/models/Entities/farm.dart';
import 'package:hackathon_app/provider/igeneric_provider.dart';

class FarmProvider extends ChangeNotifier with IGenericProvider<Farm>,  MessageNotifierMixin {
  
 

  @override
  void doNull() {
    t = null;
    list = null;
  
  }
  IFarmServices _iFarmServices;

  FarmProvider({required IFarmServices iFarmServices})
      : _iFarmServices = iFarmServices;

  Future<void> create(Farm farmU) async {
    try {
      int farmValue = await _iFarmServices.create(farmU);
      if (farmValue >= 0) {
        farmU.farmId = farmValue;
        t = farmU;
        list!.add(t!);
        t=null;
        notifyInfo("finca con ${farmU.farmName} creada");
      }
    } catch (e) {
      notifyError("Error en el servidor");

    }
      notifyListeners();
  }

  
  Future<List<Farm>> getAllFarmByUserId(int userId) async {
    
    if (list!= null) {
      return list!;
    }
   
    list= await _iFarmServices.getAllFarmByUser(userId);
 
    notifyListeners();
    return list!;
  }

}
