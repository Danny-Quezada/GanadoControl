import 'package:hackathon_app/app_core/iservices/itreatment_service.dart';
import 'package:hackathon_app/domain/interfaces/itreatment.dart';
import 'package:hackathon_app/domain/models/Entities/treatment.dart';

class TreatmentServices implements ITreatmentServices {
  ITreatmentModel iTreatmentModel;

  TreatmentServices({required this.iTreatmentModel});

  @override
  Future<int> create(Treatment t) async {
    return await iTreatmentModel.create(t);
  }

  @override
  Future<bool> delete(Treatment t) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<Treatment>> getAllTreatmentByFarm(int farmId) async {
    return await iTreatmentModel.getAllTreatmentByFarm(farmId);
  }

  @override
  Future<Treatment> getTreatment(int treatmentId) {
    // TODO: implement getTreatment
    throw UnimplementedError();
  }

  @override
  Future<List<Treatment>> read() {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<bool> update(Treatment t) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
