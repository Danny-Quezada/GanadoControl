import 'package:hackathon_app/ui/util/string_extensions.dart';

class ValidatorTextField{
  String? password;
  static String? userNameValidator(String? s){
    if(s==null || s.isWhitespace()){
      return "Nombre de usuario es requerido";
    }
    if(s.length<8){
      return "Nombre de usuario no es lo suficientemente largo";
    }
  }
  static String? emailValidator(String? s){
    if(s==null || s.isWhitespace()){
      return "Correo es requerido";
    }
    if(!s.isValidEmail()){
      return "Correo electronico invalido";
    }
  }
  static String? passwordValidator(String? s){
    if(s==null || s.isWhitespace()){
      return "Contraseña es requerida";
    }
    if(!s.isValidPassword()){
      return "Tu contraseña no es lo suficientemente grande";
    }
  }
   String? passwordConfirmationValidator(String? s, String? password){
    if(s==null || s.isWhitespace()){
      return "Confirmación de contraseña es requerida";
    }
    if(s!=password){
      return "Confirmación mala, intenta de nuevo" ;
    }
  }
}