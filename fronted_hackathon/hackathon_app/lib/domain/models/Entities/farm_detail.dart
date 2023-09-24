class FarmDetail {
  double farmDetailId;
  double userId;
  double farmId;
  DateTime date;

  FarmDetail(
      {required this.farmDetailId,
      required this.userId,
      required this.farmId,
      required this.date});

  factory FarmDetail.fromJson(Map<String, dynamic> json) {
    return FarmDetail(
        farmDetailId: json['IdDetalleFinca'] as double,
        userId: json['IdUsuario'] as double,
        farmId: json['IdFinca'] as double,
        date: DateTime.parse(json['Fecha']));
  }

  Map<String, dynamic> toJson() {
    return {
      'IdDetalleFinca': farmDetailId,
      'IdUsuario': userId,
      'IdFinca': farmId,
      'Fecha': date.toString(),
    };
  }
}
