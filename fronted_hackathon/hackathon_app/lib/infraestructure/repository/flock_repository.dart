
import 'package:dio/dio.dart';
import 'package:hackathon_app/domain/constant.dart';
import 'package:hackathon_app/domain/interfaces/iflock_model.dart';
import 'package:hackathon_app/domain/models/Entities/flock.dart';

class FlockRepository implements IFlockModel {

  Dio dio=Dio();
  @override
  Future<int> create(Flock t)async {
   try{
      FormData formData=FormData.fromMap(t.toJson()..addAll({"FotoURL": await MultipartFile.fromFile(t.imagePath,filename:t.imageName)}));
      var response=await dio.post(Constant.createGroup,data: formData);
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
  Future<bool> delete(Flock t) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<Flock>> getAllFlockByFinca(int farmId) async{
     List<Flock> flocks=[];
   try{
      var response=await dio.get("${Constant.getGroups}/$farmId");
      if(response.statusCode==200){
        List<dynamic> data=response.data;
        print(response.data);
        data.forEach((element) { 
          flocks.add(Flock.fromJson(element));
        });
        return flocks;
      }
      throw Exception("Hubo un error, intente nuevamente.");
   }
   catch(e){
    throw Exception("Error en el servidor.");
   }
  }

  @override
  Future<Flock> getFlock(int flockId) {
    // TODO: implement getFlock
    throw UnimplementedError();
  }

  @override
  Future<List<Flock>> read() {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<bool> update(Flock t) {
    // TODO: implement update
    throw UnimplementedError();
  }
  
}