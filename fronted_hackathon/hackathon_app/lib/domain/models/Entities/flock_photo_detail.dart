class FlockPhotoDetail {
    FlockPhotoDetail({
         this.flockId=0,
        required this.urlPhoto,
    });

     int? flockId;
    final String urlPhoto;

    factory FlockPhotoDetail.fromJson(Map<String, dynamic> json){ 
        return FlockPhotoDetail(
            flockId: json["IdGrupo"] ?? 0,
            urlPhoto: json["FotoURL"] ?? "",
        );
    }

    Map<String, dynamic> toJson() => {
        "IdGrupo": flockId,
        "FotoURL": urlPhoto,
    };

}
