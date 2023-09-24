class CowCalving {
    CowCalving({
         this.cowCalvingId=0,
        required this.cattleId,
        required this.type,
        required this.successful,
        required this.date,
    });

     int? cowCalvingId;
    final String cattleId;
    final String type;
    final bool successful;
    final DateTime? date;

    factory CowCalving.fromJson(Map<String, dynamic> json){ 
        return CowCalving(
            cowCalvingId: json["Id"] ?? 0,
            cattleId: json["IdGanado"] ?? "",
            type: json["Tipo"] ?? "",
            successful: json["Exitoso"] ?? false,
            date: DateTime.tryParse(json["Fecha"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "Id": cowCalvingId,
        "IdGanado": cattleId,
        "Tipo": type,
        "Exitoso": successful,
        "Fecha": date?.toIso8601String(),
    };

}
