import 'package:hackathon_app/domain/interfaces/imodel.dart';
import 'package:hackathon_app/domain/models/Entities/treatment.dart';

abstract class ITreatmentModel extends IModel<Treatment> {
  Future<List<Treatment>> getAllTreatmentByFarm(int farmId);
  Future<Treatment> getTreatment(int treatmentId);
}
