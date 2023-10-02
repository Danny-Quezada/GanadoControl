import 'package:hackathon_app/domain/models/Entities/entity_image.dart';

class Meditation with EntityImage{
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
        
        required this.farmId,
        this.isSelected=false,
        this.urlPhoto="",
    });
    bool? isSelected;
     int? meditationId;
    final String meditationName;
    final String provider;
    final String type;
    final String measurementUnit;
    final DateTime? expirationDate;
    final DateTime? deliveryDate;
    final String price;
    final int quantity;
     String? urlPhoto;
    final int farmId;

    factory Meditation.fromJson(Map<String, dynamic> json){ 
        return Meditation(
            meditationId: json["id"] ?? 0,
            meditationName: json["nombre"] ?? "",
            provider: json["proveedor"] ?? "",
            type: json["tipo"] ?? "",
            measurementUnit: json["unidadMedida"] ?? "",
            expirationDate: DateTime.tryParse(json["fechaCaducidad"] ?? ""),
            deliveryDate: DateTime.tryParse(json["fechaEntrega"] ?? ""),
            price: json["precio"].toString() ?? "",
            quantity: json["cantidad"] ?? 0,
            urlPhoto: json["fotoURL"] ?? "",
            farmId: json["idFinca"] ?? 0,
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
        "IdFinca": farmId,
    };

}
