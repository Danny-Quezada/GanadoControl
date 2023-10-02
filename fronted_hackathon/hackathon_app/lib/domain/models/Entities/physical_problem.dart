class PhysicalProblem {
    PhysicalProblem({
         this.physicalProblemId=0,
        required this.cattleId,
        required this.partName,
        required this.description,
    });

     int? physicalProblemId;
    final String cattleId;
    final String partName;
     String description;

    factory PhysicalProblem.fromJson(Map<String, dynamic> json){ 
        return PhysicalProblem(
            physicalProblemId: json["Id"] ?? 0,
            cattleId: json["IdGanado"] ?? "",
            partName: json["NombreParte"] ?? "",
            description: json["Descripcion"] ?? "",
        );
    }

    Map<String, dynamic> toJson() => {
        "Id": physicalProblemId,
        "IdGanado": cattleId,
        "NombreParte": partName,
        "Descripcion": description,
    };

}
