class AnimalHealthCalendar {
    AnimalHealthCalendar({
        this.animalHealthCalendarId=0,
        required this.date,
        required this.title,
        required this.description,
        required this.cattleId,
    });

    int? animalHealthCalendarId;
    final DateTime? date;
    final String title;
    final String description;
    final String cattleId;

    factory AnimalHealthCalendar.fromJson(Map<String, dynamic> json){ 
        return AnimalHealthCalendar(
            animalHealthCalendarId: json["Id"] ?? 0,
            date: DateTime.tryParse(json["Fecha"] ?? ""),
            title: json["Titulo"] ?? "",
            description: json["Descripcion"] ?? "",
            cattleId: json["IdGanado"] ?? "",
        );
    }

    Map<String, dynamic> toJson() => {
        "Id": animalHealthCalendarId,
        "Fecha": date?.toIso8601String(),
        "Titulo": title,
        "Descripcion": description,
        "IdGanado": cattleId,
    };

}
