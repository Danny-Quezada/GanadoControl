class Flock {
    Flock({
         this.flockId=0,
        required this.flockName,
        required this.farmId,
    });

    int? flockId;
    final String flockName;
    final int farmId;

    factory Flock.fromJson(Map<String, dynamic> json){ 
        return Flock(
            flockId: json["IdGrupo"] ?? 0,
            flockName: json["Nombre"] ?? "",
            farmId: json["IdFinca"] ?? 0,
        );
    }

    Map<String, dynamic> toJson() => {
        "IdGrupo": flockId,
        "Nombre": flockName,
        "IdFinca": farmId,
    };

}
