class Meditation {
    Meditation({
         this.meditationId=0,
        required this.meditationName,
        required this.provider,
        required this.type,
        required this.measurementUnit,
        required this.expirationDate,
        required this.deliveryDate,
        required this.price,
        required this.quantity,
        required this.urlPhoto,
        required this.farmId,
    });

     int? meditationId;
    final String meditationName;
    final String provider;
    final String type;
    final String measurementUnit;
    final DateTime? expirationDate;
    final DateTime? deliveryDate;
    final String price;
    final int quantity;
    final String urlPhoto;
    final int farmId;

    factory Meditation.fromJson(Map<String, dynamic> json){ 
        return Meditation(
            meditationId: json["Id"] ?? 0,
            meditationName: json["Nombre"] ?? "",
            provider: json["Proveedor"] ?? "",
            type: json["Tipo"] ?? "",
            measurementUnit: json["UnidadMedida"] ?? "",
            expirationDate: DateTime.tryParse(json["FechaCaducidad"] ?? ""),
            deliveryDate: DateTime.tryParse(json["FechaEntrega"] ?? ""),
            price: json["Precio"] ?? "",
            quantity: json["Cantidad"] ?? 0,
            urlPhoto: json["FotoURL"] ?? "",
            farmId: json["IdFinca"] ?? 0,
        );
    }

    Map<String, dynamic> toJson() => {
        "Id": meditationId,
        "Nombre": meditationName,
        "Proveedor": provider,
        "Tipo": type,
        "UnidadMedida": measurementUnit,
        "FechaCaducidad": expirationDate?.toIso8601String(),
        "FechaEntrega": deliveryDate?.toIso8601String(),
        "Precio": price,
        "Cantidad": quantity,
        "FotoURL": urlPhoto,
        "IdFinca": farmId,
    };

}
