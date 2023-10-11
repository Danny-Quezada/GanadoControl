import 'package:hackathon_app/domain/models/Entities/entity_image.dart';

class Cattle with EntityImage {
  String idCattle;
  String race;
  double weight;
  DateTime birthDate;
  String type;
  String? fatherId;
  String? motherId;
  int groupId;
  bool? isSelected;
  String? urlImage;
  String? status;
  DateTime? lastVaccine;
  DateTime? lastDeworming;
  Cattle(
      {required this.idCattle,
      required this.race,
      required this.weight,
      required this.birthDate,
      required this.type,
      required this.groupId,
      this.motherId = "",
      this.fatherId = "",
      this.isSelected = false,
      this.urlImage = "",
      this.status = "",
      this.lastVaccine,
      this.lastDeworming});

  factory Cattle.fromJson(Map<String, dynamic> json) {
    return Cattle(
        idCattle: json['idGanado'] as String,
        type: json['tipo'] as String,
        lastVaccine: DateTime.parse(json['ultimaVacuna']),
        lastDeworming: DateTime.parse(json['ultimadesparacitacion']),
        birthDate: DateTime.parse(json['fechaNacimiento']),
        race: json['raza'] as String,
        weight: json['peso'] is String
            ? double.parse(json['peso'])
            : json['peso'] * 1.0,
        fatherId: json['idPadre'] ?? "",
        motherId: json['idMadre'] ?? "",
        groupId: json['idGrupo'] as int,
        status: json['estado'] as String);
  }

  Map<String, dynamic> toJson() {
    return {
      'idGanado': idCattle,
      'raza': race,
      'peso': weight,
      'fechaNacimiento': birthDate!.toUtc().toString(),
      'tipo': type,
      'idPadre': fatherId,
      'idMadre': motherId,
      'idGrupo': groupId,
      'estado': status,
      'ultimaVacuna': lastVaccine,
      'ultimadesparacitacion': lastDeworming,
    };
  }
}
