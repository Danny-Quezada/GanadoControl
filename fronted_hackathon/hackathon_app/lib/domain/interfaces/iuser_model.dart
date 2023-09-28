import 'package:hackathon_app/domain/interfaces/imodel.dart';
import 'package:hackathon_app/domain/models/Entities/user.dart';

abstract class IUserModel extends IModel<User>{
  Future<User> verifyUser(String userName, String password);
  Future<String> changeState(int userId, bool state);

}