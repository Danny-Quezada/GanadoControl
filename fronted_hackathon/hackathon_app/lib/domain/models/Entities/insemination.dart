class Insemination {
    Insemination({
        required this.cattleId,
        required this.inseminationDate,
    });

    final String cattleId;
    final DateTime? inseminationDate;

    factory Insemination.fromJson(Map<String, dynamic> json){ 
        return Insemination(
            cattleId: json["IdGanado"] ?? "",
            inseminationDate: DateTime.tryParse(json["FechaInseminacion"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "IdGanado": cattleId,
        "FechaInseminacion": inseminationDate?.toIso8601String(),
    };

}
