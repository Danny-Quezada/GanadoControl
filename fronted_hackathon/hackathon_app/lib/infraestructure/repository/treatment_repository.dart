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
      if (response.statusCode == 201) {
        return await response.data;
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
    List<Treatment> treatments = [];

    try {
      var response = await dio.get("${Constant.getTreatmentByCattle}",
          queryParameters: {'Ganado': IdCattle});
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        if (data.length == 0) {
          return [];
        }
        data.forEach((element) {
          treatments.add(Treatment.fromJson(element));
        });
        return treatments;
      }
      throw Exception("Hubo un error, intente nuevamente.");
    } catch (e) {
      throw Exception("Error en el servidor.");
    }
  }

  @override
  Future<List<Treatment>> getTreatmentByGroup(String IdGroup) async {
    List<Treatment> treatments = [];

    try {
      var response = await dio.get("${Constant.getTreatmentByGroup}/$IdGroup");
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        data.forEach((element) {
          treatments.add(Treatment.fromJson(element));
        });
        return treatments;
      }
      throw Exception("Hubo un error, intente nuevamente.");
    } catch (e) {
      throw Exception("Error en el servidor.");
    }
  }

  @override
  Future<List<Treatment>> getTreatmentByUser(String IdUser) async {
    List<Treatment> treatments = [];

    try {
      var response = await dio.get("${Constant.getTreatmentByUser}/$IdUser");
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        data.forEach((element) {
          treatments.add(Treatment.fromJson(element));
        });
        return treatments;
      }
      throw Exception("Hubo un error, intente nuevamente.");
    } catch (e) {
      throw Exception("Error en el servidor.");
    }
  }

  @override
  Future<List<Treatment>> getAllTreatmentByFarm(String IdFarm) async {
    List<Treatment> treatments = [];

    try {
      var response = await dio.get("${Constant.getTreatmentByFarm}/$IdFarm");
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        data.forEach((element) {
          treatments.add(Treatment.fromJson(element));
        });
        return treatments;
      }
      throw Exception("Hubo un error, intente nuevamente.");
    } catch (e) {
      throw Exception("Error en el servidor.");
    }
  }
}
