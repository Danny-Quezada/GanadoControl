import 'package:hackathon_app/domain/interfaces/imodel.dart';
import 'package:hackathon_app/domain/models/Entities/treatment.dart';

abstract class ITreatmentModel extends IModel<Treatment> {
  Future<List<Treatment>> getTreatmentByUser(int IdUser);
  Future<List<Treatment>> getTreatmentByCattle(int IdCattle);
  Future<List<Treatment>> getAllTreatmentByFarm(int IdFarm);
  Future<List<Treatment>> getTreatmentByGroup(int IdGroup);
}
