import 'package:dio/dio.dart';
import 'package:hackathon_app/domain/constant.dart';
import 'package:hackathon_app/domain/interfaces/imeditation_model.dart';
import 'package:hackathon_app/domain/models/Entities/meditation.dart';

class MeditationRepository implements IMeditationModel{
  Dio dio=Dio();
  @override
  Future<int> create(Meditation t) async{
       try{
      FormData formData=FormData.fromMap(t.toJson()..addAll({"Foto": await MultipartFile.fromFile(t.imagePath,filename:t.imageName)}));
      var response=await dio.post(Constant.createMeditation,data: formData);
      if(response.statusCode==200){
        int value=response.data;
        return value;
      }
      throw Exception("No se ha podido agregar el medicamento");
    }
    catch(e){
      throw Exception("El servidor dió error");
    }
  }

  @override
  Future<bool> delete(Meditation t) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<Meditation>> getMeditationByFarm(int FarmId) async{
    List<Meditation> meditations=[];
   try{
      var response=await dio.get("${Constant.getMeditationbyFarm}/$FarmId");
      if(response.statusCode==200){
        List<dynamic> data=await response.data;
        print(response.data);
        data.forEach((element) { 
          meditations.add(Meditation.fromJson(element));
        });
        return meditations;
      }
      throw Exception("Hubo un error, intente nuevamente.");
   }
   catch(e){
    print(e);
    throw Exception("Error en el servidor.");
   }
  }

  @override
  Future<List<Meditation>> read() {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<bool> update(Meditation t) {
    // TODO: implement update
    throw UnimplementedError();
  }

}