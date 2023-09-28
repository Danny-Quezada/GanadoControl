import 'package:flutter/material.dart';
import 'package:hackathon_app/app_core/iservices/iuser_services.dart';
import 'package:hackathon_app/domain/models/Entities/user.dart';

class UserProvider with ChangeNotifier {
  String userError="";
  IUserServices _iUserServices;
  User? user;

  UserProvider({required IUserServices iUserServices}) : _iUserServices = iUserServices;

  Future<void> create(User userU) async {
    try{
    int userValue = await _iUserServices.create(userU);
    if (userValue>=0) {
      userU.userId=userValue;
      user = userU;
      
    }
    }
    catch(e){
      userError=e.toString();
       notifyListeners();
    }
   
  }

  Future<void> verifyUser(String userName, password) async {
    try{
       user = await _iUserServices.verifyUser(userName, password);
    }
    catch(e){
      userError=e.toString();
       notifyListeners();
    }
   
  }
  Future<String> changeState(bool state)async{
    return await _iUserServices.changeState(user!.userId!, state);
  }
  void changeError(){
    userError="";
    notifyListeners();
  }
 
}
