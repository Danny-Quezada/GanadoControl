import 'package:dio/dio.dart';
import 'package:hackathon_app/domain/constant.dart';
import 'package:hackathon_app/domain/interfaces/iphysical_problem_model.dart';
import 'package:hackathon_app/domain/models/Entities/physical_problem.dart';

class PhysicalProblemRepository implements IPhysicalProblemModel {
  Dio dio = Dio();

  @override
  Future<int> create(PhysicalProblem t) async {
    try {
      FormData formData = FormData.fromMap(t.toJson());
      var response =
          await dio.post(Constant.createPhysicalProblem, data: formData);
      if (response.statusCode == 201) {
        // int value = await response.data;
        return 0;
      }
      throw Exception("Problema fisico no registrado, intente más tarde");
    } catch (e) {
      throw Exception("Hubo un problema con el servidor");
    }
  }

  @override
  Future<bool> delete(PhysicalProblem t) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<PhysicalProblem>> getPhysicalProblemByCattle(
      String IdCattle) async {
    List<PhysicalProblem> physicalProblems = [];

    try {
      var response = await dio.get("${Constant.getPhysicalProblemByCattle}",
          queryParameters: {'idGanado': IdCattle});
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        if (data.length == 0) {
          return [];
        }
        data.forEach((element) {
          physicalProblems.add(PhysicalProblem.fromJson(element));
        });
        return physicalProblems;
      }
      throw Exception("Hubo un error, intente nuevamente.");
    } catch (e) {
      throw Exception("Error en el servidor.");
    }
  }

  @override
  Future<List<PhysicalProblem>> read() {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<bool> update(PhysicalProblem t) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
