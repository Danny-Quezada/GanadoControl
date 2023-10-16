import 'package:dio/dio.dart';
import 'package:hackathon_app/domain/constant.dart';
import 'package:hackathon_app/domain/interfaces/ianimal_health_calendar_model.dart';
import 'package:hackathon_app/domain/models/Entities/animal_health_calendar.dart';

class AnimalHealtCalendarRepository implements IAnimalHealtCalendarModel {
  Dio dio = Dio();

  @override
  Future<int> create(AnimalHealthCalendar t) async {
    try {
      FormData formData = FormData.fromMap(t.toJson());
      var response =
          await dio.post(Constant.createAnimalHeartCalendar, data: formData);
      if (response.statusCode == 201) {
        return await response.data;
      }
      throw Exception("Problema fisico no registrado, intente más tarde");
    } catch (e) {
      throw Exception("Hubo un problema con el servidor");
    }
  }

  @override
  Future<bool> delete(AnimalHealthCalendar t) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<AnimalHealthCalendar>> getPhysicalProblemByCattle(
      String IdCattle) async {
    List<AnimalHealthCalendar> animalHealtCalendar = [];

    try {
      var response = await dio.get("${Constant.getAnimalHeartCalendarByCattle}",
          queryParameters: {'idGanado': IdCattle});
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        if (data.length == 0) {
          return [];
        }
        data.forEach((element) {
          animalHealtCalendar.add(AnimalHealthCalendar.fromJson(element));
        });
        return animalHealtCalendar;
      }
      throw Exception("Hubo un error, intente nuevamente.");
    } catch (e) {
      throw Exception("Error en el servidor.");
    }
  }

  @override
  Future<List<AnimalHealthCalendar>> read() {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<bool> update(AnimalHealthCalendar t) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
