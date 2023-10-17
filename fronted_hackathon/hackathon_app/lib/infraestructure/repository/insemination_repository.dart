import 'package:dio/dio.dart';
import 'package:hackathon_app/domain/constant.dart';
import 'package:hackathon_app/domain/interfaces/iinsermination_model.dart';
import 'package:hackathon_app/domain/models/Entities/insemination.dart';

class InseminationRepository implements IInseminationModel {
  Dio dio = Dio();

  @override
  Future<int> create(Insemination t) async {
    try {
      FormData formData = FormData.fromMap(t.toJson());
      var response =
          await dio.post(Constant.createInsemination, data: formData);
      if (response.statusCode == 201 || response.data == 200) {
        return await response.data;
      }
      throw Exception("Inseminacion no registrado, intente más tarde");
    } catch (e) {
      throw Exception("Hubo un problema con el servidor");
    }
  }

  @override
  Future<bool> delete(Insemination t) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<Insemination>> read() {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<bool> update(Insemination t) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
