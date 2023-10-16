class PhysicalProblem {
  PhysicalProblem({
    this.physicalProblemId = 0,
    required this.cattleId,
    required this.partName,
    required this.description,
  });

  int? physicalProblemId;
  String cattleId;
  final String partName;
  String description;

  factory PhysicalProblem.fromJson(Map<String, dynamic> json) {
    return PhysicalProblem(
      physicalProblemId: json["id"] ?? 0,
      cattleId: json["idGanado"] ?? "",
      partName: json["nombreParte"] ?? "",
      description: json["descripcion"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "Id": physicalProblemId,
        "IdGanado": cattleId,
        "NombreParte": partName,
        "Descripcion": description,
      };
}
