import 'package:flutter/material.dart';
import 'package:flutter_provider_utilities/flutter_provider_utilities.dart';
import 'package:hackathon_app/app_core/iservices/imeditation_services.dart';
import 'package:hackathon_app/domain/models/Entities/meditation.dart';
import 'package:hackathon_app/provider/igeneric_provider.dart';

class MeditationProvider extends ChangeNotifier  with IGenericProvider<Meditation>, MessageNotifierMixin {
   IMeditationServices _iMeditationServices;

  MeditationProvider({required IMeditationServices iFarmServices})
      : _iMeditationServices = iFarmServices;

  Future<void> create(Meditation meditation) async {
    try {
      int meditationValue = await _iMeditationServices.create(meditation);
      if (meditationValue >= 0) {
        meditation.meditationId= meditationValue;
        t = meditation;
        list!.add(t!);
        t = null;
        notifyInfo("finca: ${meditation.meditationName} creada");
      }
    } catch (e) {
      notifyError("Error en el servidor");
    }
    notifyListeners();
  }

  Future<List<Meditation>> getAllFarmByUserId(int farmId) async {

    if (list != null) {
      return list!;
    }

    list = await _iMeditationServices.getMeditationByFarm(farmId);

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
  
  find(String text){

    if(text.isEmpty){
      searchList=null;
    }
    else{
     searchList= list!
        .where((element) => element.meditationName.toLowerCase().contains(text.toLowerCase()))
        .toList();
    }
    notifyListeners();

  }
}