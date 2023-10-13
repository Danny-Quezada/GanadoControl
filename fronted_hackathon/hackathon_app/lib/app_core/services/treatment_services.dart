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
  Future<List<Treatment>> getAllTreatmentByFarm(String IdFarm) async {
    return await iTreatmentModel.getAllTreatmentByFarm(IdFarm);
  }

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

  @override
  Future<List<Treatment>> getTreatmentByCattle(String IdCattle) async {
    return await iTreatmentModel.getTreatmentByCattle(IdCattle);
  }

  @override
  Future<List<Treatment>> getTreatmentByGroup(String IdGroup) async {
    return await iTreatmentModel.getTreatmentByGroup(IdGroup);
  }

  @override
  Future<List<Treatment>> getTreatmentByUser(String IdUser) async {
    return await iTreatmentModel.getTreatmentByUser(IdUser);
  }
}
