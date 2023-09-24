class Farm {
  double? farmId;
  String farmName;
  String location;
  double hectares;
  String farmOwner;

  Farm(
      {this.farmId = 0,
      required this.farmName,
      required this.location,
      required this.hectares,
      required this.farmOwner});

  factory Farm.fromJson(Map<String, dynamic> json) {
    return Farm(
        farmId: json['Id'] as double,
        farmName: json['Nombre'] as String,
        location: json['Ubicacion'] as String,
        hectares: json['Hectareas'] as double,
        farmOwner: json['NombreDueño'] as String);
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': farmId,
      'Nombre': farmName,
      'Ubicacion': location,
      'Hectareas': hectares,
      'NombreDueño': farmOwner,
    };
  }
}
