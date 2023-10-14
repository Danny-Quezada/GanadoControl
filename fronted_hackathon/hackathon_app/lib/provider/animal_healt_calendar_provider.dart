import 'package:flutter/material.dart';
import 'package:flutter_provider_utilities/flutter_provider_utilities.dart';
import 'package:hackathon_app/app_core/iservices/ianimal_healt_calendar_services.dart';
import 'package:hackathon_app/domain/models/Entities/animal_health_calendar.dart';
import 'package:hackathon_app/provider/igeneric_provider.dart';

class AnimalHealtCalendarProvider extends ChangeNotifier
    with IGenericProvider<AnimalHealthCalendar>, MessageNotifierMixin {
  @override
  void doNull() {
    t = null;
    list = null;
  }

  IAnimalHealtCalendarServices _animalHealtCalendarServices;

  AnimalHealtCalendarProvider(
      {required IAnimalHealtCalendarServices iAnimalHealtCalendarServices})
      : _animalHealtCalendarServices = iAnimalHealtCalendarServices;

  Future<void> create(AnimalHealthCalendar animalHealthCalendar) async {
    try {
      int animalHealtCalendarValue =
          await _animalHealtCalendarServices.create(animalHealthCalendar);
      if (animalHealtCalendarValue >= 0) {
        animalHealthCalendar.animalHealthCalendarId = animalHealtCalendarValue;
        t = animalHealthCalendar;
        list!.add(t!);
        t = null;
        notifyInfo(
            "Recordatorio creado para la vaca: ${animalHealthCalendar.cattleId}");
      }
    } catch (e) {
      notifyError("Error en el servidor");
    }
    notifyListeners();
  }

  Future<List<AnimalHealthCalendar>> getAnimalHealtCalendarByCattle(
      String IdCattle) async {
    if (list != null) {
      return list!;
    }

    list =
        await _animalHealtCalendarServices.getPhysicalProblemByCattle(IdCattle);
    notifyListeners();
    return list!;
  }
}
