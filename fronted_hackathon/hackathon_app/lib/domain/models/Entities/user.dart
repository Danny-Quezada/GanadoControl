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
    final String password;
    final String workstation;

    factory User.fromJson(Map<String, dynamic> json){ 
        return User(
            userId: json["Id"] ?? 0,
            userName: json["NombreUsuario"] ?? "",
            email: json["Correo"] ?? "",
            password: json["Contraseña"] ?? "",
            workstation: json["Cargo"] ?? "",
        );
    }

    Map<String, dynamic> toJson() => {
        "Id": userId,
        "NombreUsuario": userName,
        "Correo": email,
        "Contraseña": password,
        "Cargo": workstation,
    };

}
