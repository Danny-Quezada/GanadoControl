class User {
    User({
         this.userId=0,
        required this.userName,
        required this.email,
        required this.password,
        required this.workstation,
    });

     int? userId;
    final String userName;
    final String email;
     String password;
    String workstation;

    factory User.fromJson(Map<String, dynamic> json){ 
        return User(
            userId: json["id"] ?? 0,
            userName: json["nombreUsuario"] ?? "",
            email: json["correo"] ?? "",
            password: json["contraseña"] ?? "",
            workstation: json["cargo"] ?? "",
        );
    }
 
    Map<String, dynamic> toJson() => {

        "id": userId,
        "nombreUsuario": userName,
        "correo": email,
        "contraseña": password,
        "cargo": workstation,
    };

}
