class Treatment {
  Treatment({
    this.treatmentId = 0,
    required this.cattleId,
    this.meditationName = "",
    required this.date,
    required this.type,
    required this.dosis,
    required this.observation,
    required this.aplicationArea,
    this.meditationId,
  });
  String? meditationName;
  int? treatmentId;
  final String cattleId;
  final String? meditationId;
  final DateTime? date;
  final String type;
  final double dosis;
  final String observation;
  final String aplicationArea;

  factory Treatment.fromJson(Map<String, dynamic> json) {
    return Treatment(
        treatmentId: json["id"] as int ?? 0,
        cattleId: json["idGanado"] as String,
        meditationName: json["nombreFarmaco"] as String,
        date: DateTime.tryParse(json["fecha"] ?? ""),
        type: json["tipo"] as String,
        dosis: double.parse(json["dosis"].toString()),
        observation: json["observacion"] as String,
        aplicationArea: json["areaAplicacion"] as String);
  }

  Map<String, dynamic> toJson() {
    return {
      "Id": treatmentId,
      "IdGanado": cattleId,
      "NombreFarmaco": meditationName,
      "Fecha": date?.toIso8601String(),
      "Tipo": type,
      "Dosis": dosis,
      "Observacion": observation,
      "AreaAplicacion": aplicationArea,
      "IdFarmaco": meditationId,
    };
  }
}
