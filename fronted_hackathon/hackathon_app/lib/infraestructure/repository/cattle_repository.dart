import 'package:dio/dio.dart';
import 'package:hackathon_app/domain/constant.dart';
import 'package:hackathon_app/domain/interfaces/icattle_model.dart';
import 'package:hackathon_app/domain/models/Entities/cattle.dart';

class CattleRepository implements ICattleModel {
  Dio dio = Dio();

  @override
  Future<int> create(Cattle t) async {
    try {
      FormData formData = FormData.fromMap(t.toJson());
      var response = await dio.post(Constant.creatCattle, data: formData);
      if (response.statusCode == 200) {
        int value = await response.data;
        return value;
      }
      throw Exception("Vaca no registrado, intente más tarde");
    } catch (e) {
      throw Exception("Hubo un problema con el servidor");
    }
  }

  @override
  Future<bool> delete(Cattle t) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<Cattle>> getAllCattleByGroup(int groupId) {
    // TODO: implement getAllCattleByGroup
    throw UnimplementedError();
  }

  @override
  Future<Cattle> getCattle(int cattleId) {
    // TODO: implement getCattle
    throw UnimplementedError();
  }

  @override
  Future<List<Cattle>> read() {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<bool> update(Cattle t) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
