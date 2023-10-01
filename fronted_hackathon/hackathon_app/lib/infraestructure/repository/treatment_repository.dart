import 'package:dio/dio.dart';
import 'package:hackathon_app/domain/constant.dart';
import 'package:hackathon_app/domain/interfaces/itreatment.dart';
import 'package:hackathon_app/domain/models/Entities/treatment.dart';

class TreatmentRepository implements ITreatmentModel {
  Dio dio = Dio();

  @override
  Future<int> create(Treatment t) async {
    try {
      FormData formData = FormData.fromMap(t.toJson());
      var response = await dio.post(Constant.createTreatment, data: formData);
      if (response.statusCode == 200) {
        int value = await response.data;
        return value;
      }
      throw Exception("Tratamiento no registrado, intente más tarde");
    } catch (e) {
      throw Exception("Hubo un problema con el servidor");
    }
  }

  @override
  Future<bool> delete(Treatment t) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<Treatment>> getAllTreatmentByFarm(int userId) {
    // TODO: implement getAllTreatmentByFarm
    throw UnimplementedError();
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
