import 'package:hackathon_app/app_core/iservices/ianimal_healt_calendar_services.dart';
import 'package:hackathon_app/domain/interfaces/ianimal_health_calendar_model.dart';
import 'package:hackathon_app/domain/models/Entities/animal_health_calendar.dart';

class AnimalHeartCalendarServices implements IAnimalHealtCalendarServices {
  IAnimalHealtCalendarModel iAnimalHealtCalendarModel;

  AnimalHeartCalendarServices({required this.iAnimalHealtCalendarModel});

  @override
  Future<int> create(AnimalHealthCalendar t) async {
    return await iAnimalHealtCalendarModel.create(t);
  }

  @override
  Future<bool> delete(AnimalHealthCalendar t) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<AnimalHealthCalendar>> getPhysicalProblemByCattle(
      String IdCattle) async {
    return await iAnimalHealtCalendarModel.getPhysicalProblemByCattle(IdCattle);
  }

  @override
  Future<List<AnimalHealthCalendar>> read() {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<bool> update(AnimalHealthCalendar t) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
