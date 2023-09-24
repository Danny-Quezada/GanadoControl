class FarmPhotoDetail {
    FarmPhotoDetail({
        required this.farmId,
        required this.urlPhoto,
    });

    final int farmId;
    final String urlPhoto;

    factory FarmPhotoDetail.fromJson(Map<String, dynamic> json){ 
        return FarmPhotoDetail(
            farmId: json["IdFinca"] ?? 0,
            urlPhoto: json["FotoURL"] ?? "",
        );
    }

    Map<String, dynamic> toJson() => {
        "IdFinca": farmId,
        "FotoURL": urlPhoto,
    };

}