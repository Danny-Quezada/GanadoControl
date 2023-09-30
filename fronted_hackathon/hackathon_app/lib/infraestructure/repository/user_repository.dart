import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hackathon_app/domain/constant.dart';
import 'package:hackathon_app/domain/interfaces/iuser_model.dart';
import 'package:hackathon_app/domain/models/Entities/user.dart';

class UserRepository implements IUserModel {
  Dio dio = Dio();
  @override
  Future<String> changeState(int userId, bool estado) async{
   try{
    var response=await dio.put(Constant.userChangeState,queryParameters: {
      "id": userId,
      "estado": estado
    });
    return await response.data;
   } 
   catch(e){
     throw Exception("Hubo un problema con el servidor");
   }
  }

  @override
  Future<int> create(User t)async {
    FormData formData=FormData.fromMap(t.toJson());
    
    try{
      var response=await dio.post(Constant.createUser,data: formData);
      if(response.statusCode==200){
        int value=await response.data;
        return value;
      }
      throw Exception("Usuario no registrado, intente más tarde");
    }
    catch(e){
      throw Exception("Hubo un problema con el servidor");
    }
  }

  @override
  Future<bool> delete(User t) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<User>> read() {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<bool> update(User t) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<User> verifyUser(String userName, String password) async {
    try{
    // var response = await dio.get(Constant.getUser,
    //     queryParameters: {"nombreUsuario": userName, "contraseña": password});


    var response=await dio.get(Constant.getUser+"/$userName, $password");
    if(response.statusCode==200){
        print(response.data.toString());
        User user=User.fromJson( response.data);
        user.password= password;
      
        return user; 
      }
      throw Exception("Usuario no encontrado");
    }
    catch(e){
      throw Exception("Ocurrió un problema con el servidor");
    }
  }
}
