import 'package:hackathon_app/ui/util/string_extensions.dart';

class ValidatorTextField{


    static String? genericDecimalValidator(String? s){
       if(s==null || s.isWhitespace()){
      return "Campo requerido";
    }
    else if(double.tryParse(s)!=null){
      double? value=double.tryParse(s);
      if(value!<=0){
        return "No puede ser menor o igual que 0";
      }
    }
    
    }

  static String? genericNumberValidator(String? s){
  
     if(s==null || s.isWhitespace()){
      return "Campo requerido";
    }
   
    else if(int.tryParse(s)!=null){
      int? value=int.tryParse(s);
      if(value!<0){
        return "No puede ser menor que 0";
      }
    }
    else{
      return "Campo debe de ser un número entero";
    }
  }

  static String? genericStringValidator(String? s){
     if(s==null || s.isWhitespace()){
      return "Campo requerido";
    }
  }
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