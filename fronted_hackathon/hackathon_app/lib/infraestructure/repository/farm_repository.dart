import 'package:dio/dio.dart';
import 'package:hackathon_app/domain/constant.dart';
import 'package:hackathon_app/domain/interfaces/ifarm_model.dart';
import 'package:hackathon_app/domain/models/Entities/farm.dart';

class FarmRepository  implements IFarmModel{


  Dio dio=Dio();
  @override
  Future<int> create(Farm t)async {
   
    try{
      FormData formData=FormData.fromMap(t.toJson()..addAll({"FotoURL": await MultipartFile.fromFile(t.imagePath,filename:t.imageName)}));
      var response=await dio.post(Constant.createFarm,data: formData);
      if(response.statusCode==200){
        int value=response.data;
        return value;
      }
      throw Exception("No se ha podido agregar la finca");
    }
    catch(e){
      throw Exception("El servidor dió error");
    }
    
  }

  @override
  Future<bool> delete(Farm t) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<Farm>> getAllFarmByUser(int userId) async{
    List<Farm> farms=[];
   try{
      var response=await dio.get("${Constant.getFarms}/$userId");
      if(response.statusCode==200){
        List<dynamic> data=response.data;
        print(response.data);
        data.forEach((element) { 
          farms.add(Farm.fromJson(element));
        });
        return farms;
      }
      throw Exception("Hubo un error, intente nuevamente.");
   }
   catch(e){
    throw Exception("Error en el servidor.");
   }
  }

  @override
  Future<Farm> getFarm(int farmId) {
    // TODO: implement getFarm
    throw UnimplementedError();
  }

  @override
  Future<List<Farm>> read() {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<bool> update(Farm t) {
    // TODO: implement update
    throw UnimplementedError();
  }

}