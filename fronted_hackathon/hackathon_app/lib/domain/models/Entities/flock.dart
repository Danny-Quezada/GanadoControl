import 'package:hackathon_app/domain/models/Entities/entity_image.dart';
import 'package:hackathon_app/domain/models/Entities/reflection.dart';
import 'package:reflectable/reflectable.dart';

const myReflectable=MyReflectable();

@myReflectable
class Flock with EntityImage {



    Flock({
      this.flockImage="",
 
      this.cattleQuantity=0,
         this.flockId=0,
        required this.flockName,
        required this.farmId,
    });

 

    int? cattleQuantity;
    int? flockId;
    String? flockImage;
    
    final String flockName;
     int farmId;

    factory Flock.fromJson(Map<String, dynamic> json){ 
        return Flock(
          cattleQuantity: json["cantidadGanado"] ?? 0,
          flockImage: json["fotoURL"] ?? "",
            flockId: json["idGrupo"] ?? 0,
            flockName: json["nombre"] ?? "",
            farmId: json["idFinca"] ?? 0,
            
        );
    }

    Map<String, dynamic> toJson() => {
        "IdGrupo": flockId,
        "Nombre": flockName,
        "IdFinca": farmId,
        
    };

}
