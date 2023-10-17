class Insemination {
  Insemination(
      {required this.cattleId,
      required this.inseminationDate,
      this.IdInsemination});

  final int? IdInsemination;
  final String cattleId;
  final DateTime? inseminationDate;

  factory Insemination.fromJson(Map<String, dynamic> json) {
    return Insemination(
      IdInsemination: int.parse(json["Id"]),
      cattleId: json["IdGanado"] ?? "",
      inseminationDate: DateTime.tryParse(json["FechaInseminacion"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "Id": IdInsemination,
        "IdGanado": cattleId,
        "FechaInseminacion": inseminationDate?.toIso8601String(),
      };
}
