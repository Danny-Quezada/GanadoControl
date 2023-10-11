import 'package:hackathon_app/app_core/iservices/iservices.dart';
import 'package:hackathon_app/domain/models/Entities/treatment.dart';

abstract class ITreatmentServices extends IServices<Treatment> {
  Future<List<Treatment>> getTreatmentByUser(int IdUser);
  Future<List<Treatment>> getTreatmentByCattle(int IdCattle);
  Future<List<Treatment>> getAllTreatmentByFarm(int farmId);
  Future<List<Treatment>> getTreatmentByGroup(int IdGroup);
}
