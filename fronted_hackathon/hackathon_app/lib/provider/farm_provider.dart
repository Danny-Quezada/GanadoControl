import 'package:flutter/material.dart';
import 'package:hackathon_app/app_core/iservices/ifarm_services.dart';
import 'package:hackathon_app/domain/models/Entities/farm.dart';

class FarmProvider with ChangeNotifier {
  String farmError = "";
  List<Farm>? farms;
  Farm? farm;
  IFarmServices _iFarmServices;

  FarmProvider({required IFarmServices iFarmServices})
      : _iFarmServices = iFarmServices;

  Future<void> create(Farm farmU) async {
    try {
      int userValue = await _iFarmServices.create(farmU);
      if (userValue >= 0) {
        farmU.farmId = userValue;
        farm = farmU;
      }
    } catch (e) {
      farmError = e.toString();
      notifyListeners();
    }
  }

  void farmNull() {
    farms=null;
    farm = null;
  }
 final Stopwatch _stopwatch=Stopwatch();
  Future<List<Farm>> getAllFarmByUserId(int userId)async{
    if(farms!=null){
    return farms!;
    
   
    }
    _stopwatch.start();
    farms=await _iFarmServices.getAllFarmByUser(userId);
    _stopwatch.stop();
    print("Tiempo en segundos para obtener las fincas del usuario: "+(_stopwatch.elapsedMilliseconds/1000).toString());
    notifyListeners();
    return farms!;
  }
}
