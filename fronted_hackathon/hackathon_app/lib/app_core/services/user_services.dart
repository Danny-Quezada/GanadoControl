import 'package:hackathon_app/app_core/iservices/iuser_services.dart';
import 'package:hackathon_app/app_core/services/shared_preferences_services.dart';
import 'package:hackathon_app/domain/interfaces/iuser_model.dart';
import 'package:hackathon_app/domain/models/Entities/user.dart';

class UserServices implements IUserServices {
  IUserModel iUserModel;

  UserServices({required this.iUserModel});
  @override
  Future<String> changeState(int userId, bool estado) {
    return iUserModel.changeState(userId, estado);
  }

  @override
  Future<int> create(User t) async {
    int value = await iUserModel.create(t);
    await SharedPreferencesServices.saveUser(t);
    return value;
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
    User user = await iUserModel.verifyUser(userName, password);

    SharedPreferencesServices.saveUser(user);
    return user;
  }
}
