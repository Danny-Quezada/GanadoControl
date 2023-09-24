class CattleDetail {
  String cattleId;
  String urlPhoto;

  CattleDetail({required this.cattleId, required this.urlPhoto});

  factory CattleDetail.fromJson(Map<String, dynamic> json) {
    return CattleDetail(
        cattleId: json['IdGanado'] as String,
        urlPhoto: json['FotoURL'] as String);
  }

  Map<String, dynamic> toJson() {
    return {
      'IdGanado': cattleId,
      'FotoURL': urlPhoto,
    };
  }
}
