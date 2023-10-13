import 'package:hackathon_app/domain/interfaces/imodel.dart';
import 'package:hackathon_app/domain/models/Entities/treatment.dart';

abstract class ITreatmentModel extends IModel<Treatment> {
  Future<List<Treatment>> getTreatmentByUser(String IdUser);
  Future<List<Treatment>> getTreatmentByCattle(String IdCattle);
  Future<List<Treatment>> getAllTreatmentByFarm(String IdFarm);
  Future<List<Treatment>> getTreatmentByGroup(String IdGroup);
}
