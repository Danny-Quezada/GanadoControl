import 'package:hackathon_app/app_core/iservices/iservices.dart';
import 'package:hackathon_app/domain/models/Entities/treatment.dart';

abstract class ITreatmentServices extends IServices<Treatment> {
  Future<List<Treatment>> getTreatmentByUser(String IdUser);
  Future<List<Treatment>> getTreatmentByCattle(String IdCattle);
  Future<List<Treatment>> getAllTreatmentByFarm(String IdFarm);
  Future<List<Treatment>> getTreatmentByGroup(String IdGroup);
}
