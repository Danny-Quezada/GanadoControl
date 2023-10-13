import 'package:hackathon_app/domain/models/Entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesServices {
  static saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setInt("userId", user.userId!);
    await prefs.setString("password", user.password);
    await prefs.setString("userName", user.userName);

    await prefs.setString("workstation", user.workstation);
  }

  static Future<User?> readUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString("userName") ==null){
      return null;
    }
    return User(
        userName: prefs.getString("userName")!,
        email: "",
        password: prefs.getString("password")!,
        workstation: prefs.getString("workstation")!,
        userId: prefs.getInt("userId"));
  }
 static removeUser()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove("userName");
    await prefs.remove("password");
    await prefs.remove("userId");
    await prefs.remove("workstation");
  }
}
