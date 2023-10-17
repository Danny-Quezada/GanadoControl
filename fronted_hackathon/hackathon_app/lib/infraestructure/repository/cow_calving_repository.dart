import 'package:dio/dio.dart';
import 'package:hackathon_app/domain/constant.dart';
import 'package:hackathon_app/domain/interfaces/icow_calving_model.dart';
import 'package:hackathon_app/domain/models/Entities/cow_calving.dart';

class CowCalvingRepository implements ICowCalvingModel {
  Dio dio = Dio();

  @override
  Future<int> create(CowCalving t) async {
    try {
      FormData formData = FormData.fromMap(t.toJson());
      var response = await dio.post(Constant.createCowCalving, data: formData);
      if (response.statusCode == 201 || response.statusCode == 200) {
        return await response.data;
      }
      throw Exception("Parto no registrado, intente más tarde");
    } catch (e) {
      throw Exception("Hubo un problema con el servidor");
    }
  }

  @override
  Future<bool> delete(CowCalving t) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<CowCalving>> read() {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<bool> update(CowCalving t) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
