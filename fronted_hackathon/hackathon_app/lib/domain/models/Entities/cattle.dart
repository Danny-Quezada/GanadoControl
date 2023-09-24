class Cattle {
  String idCattle;
  String race;
  double weight;
  DateTime birthDate;
  String type;
  String? fatherId;
  String? motherId;
  double groupId;

  Cattle(
      {required this.idCattle,
      required this.race,
      required this.weight,
      required this.birthDate,
      required this.type,
      required this.groupId,
      this.motherId = "",
      this.fatherId = ""});

  factory Cattle.fromJson(Map<String, dynamic> json) {
    return Cattle(
        idCattle: json['IdGanado'] as String,
        race: json['Raza'] as String,
        weight: json['Peso'] as double,
        birthDate: DateTime.parse(json['FechaNacimiento']),
        type: json['Tipo'] as String,
        groupId: json['IdGrupo'] as double,
        fatherId: json['IdPadre'] ?? "",
        motherId: json['IdMadre'] ?? "");
  }

  Map<String, dynamic> toJson() {
    return {
      'IdGanado': idCattle,
      'Raza': race,
      'Peso': weight,
      'FechaNacimiento': birthDate!.toUtc().toString(),
      'Tipo': type,
      'IdPadre': fatherId,
      'IdMadre': motherId,
      'IdGrupo': groupId,
    };
  }
}
