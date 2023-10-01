
import 'package:hackathon_app/domain/models/Entities/entity_image.dart';

class Farm  with EntityImage{
  String? userRole;
  int? userId;
  int? farmId;
 String farmName;
 String location;
   int hectares;
   String farmOwner;
  int? groups;
 String? urlImage;
  DateTime? creation;
  bool? isSelected;

  Farm(
      {
        
        this.urlImage="",
        this.groups=0,
        this.farmId = 0,
      required this.farmName,
      required this.location,
      required this.hectares,
      required this.farmOwner,
      this.isSelected=false});

  
  factory Farm.fromJson(Map<String, dynamic> json) {
    return Farm(
      groups: json["grupos"] as int,
      urlImage: json["fotoURL"] as String,
        farmId: json['idFinca'] as int,
        farmName: json['nombre'] as String,
        location: json['ubicacion'] as String,
        hectares: json['hectareas'] as int,
        farmOwner: json['nombreDueño'] as String);
  }

  
  Map<String, dynamic> toJson() {
    return {
      'IdFinca': farmId,
      'Nombre': farmName,
      'Ubicacion': location,
      'Hectareas': hectares,
      'NombreDueño': farmOwner,
      "IdUsuario": userId,
      "RolUsuario": userRole,
      "Fecha": creation.toString()
    };
  }
}
