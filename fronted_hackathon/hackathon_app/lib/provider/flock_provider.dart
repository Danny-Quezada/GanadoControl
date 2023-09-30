import 'package:flutter/material.dart';
import 'package:flutter_provider_utilities/flutter_provider_utilities.dart';
import 'package:hackathon_app/domain/models/Entities/flock.dart';
import 'package:hackathon_app/provider/igeneric_provider.dart';

import '../app_core/iservices/iflock_services.dart';

class FlockProvider extends ChangeNotifier with IGenericProvider<Flock>, MessageNotifierMixin{
 

  final IFlockServices _iFlockServices;

  FlockProvider({required IFlockServices iFlockServices})
      : _iFlockServices = iFlockServices;

  Future<void> create(Flock flockU) async {
    try {
      int flockValue = await _iFlockServices.create(flockU);
      if (flockValue >= 0) {
        flockU.flockId = flockValue;
        t = flockU;
        list!.add(t!);

        notifyInfo("Grupo ${flockU.flockName} creado");
        t=null;
      }
    } catch (e) {
  notifyError(e.toString());
     
    }
     notifyListeners();
  }

  
  Future<List<Flock>> getAllFlockByFarmId(int farmId) async {
    if (list!= null) {
      return list!;
    }
   
    list= await _iFlockServices.getAllFlockByFinca(farmId);
 
    notifyListeners();
    return list!;
  }
  

}