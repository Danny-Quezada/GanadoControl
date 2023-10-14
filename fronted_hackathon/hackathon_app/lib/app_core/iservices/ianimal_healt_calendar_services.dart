import 'package:hackathon_app/domain/interfaces/imodel.dart';
import 'package:hackathon_app/domain/models/Entities/animal_health_calendar.dart';

abstract class IAnimalHealtCalendarServices
    extends IModel<AnimalHealthCalendar> {
  Future<List<AnimalHealthCalendar>> getPhysicalProblemByCattle(
      String IdCattle);
}
