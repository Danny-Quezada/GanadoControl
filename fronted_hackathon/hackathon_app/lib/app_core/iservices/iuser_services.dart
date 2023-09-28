import 'package:hackathon_app/app_core/iservices/iservices.dart';
import 'package:hackathon_app/domain/models/Entities/user.dart';

abstract class IUserServices extends IServices<User>{
   Future<User> verifyUser(String userName, String password);
  Future<String> changeState(int userId, bool state);
}