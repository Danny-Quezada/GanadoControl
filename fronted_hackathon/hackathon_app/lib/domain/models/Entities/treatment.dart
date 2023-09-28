class Treatment {
    Treatment({
      this.meditationName="",
        this.treatmentId=0,
        required this.cattleId,
        required this.meditationId,
        required this.date,
        required this.type,
        required this.dosis,
        required this.observation,
        required this.aplicationArea,
    });
String? meditationName;
     int? treatmentId;
    final String cattleId;
    final int meditationId;
    final DateTime? date;
    final String type;
    final String dosis;
    final String observation;
    final String aplicationArea;

    factory Treatment.fromJson(Map<String, dynamic> json){ 
        return Treatment(
            treatmentId: json["Id"] ?? 0,
            cattleId: json["IdGanado"] ?? "",
            meditationId: json["IdFarmaco"] ?? 0,
            date: DateTime.tryParse(json["Fecha"] ?? ""),
            type: json["Tipo"] ?? "",
            dosis: json["Dosis"] ?? "",
            observation: json["Observacion"] ?? "",
            aplicationArea: json["AreaAplicacion"] ?? "",
        );
    }

    Map<String, dynamic> toJson() => {
        "Id": treatmentId,
        "IdGanado": cattleId,
        "IdFarmaco": meditationId,
        "Fecha": date?.toIso8601String(),
        "Tipo": type,
        "Dosis": dosis,
        "Observacion": observation,
        "AreaAplicacion": aplicationArea,
    };

}
