class Document {
  Document({
    required this.IdTitulo,
    required this.titulo,
    required this.descripcion,
    required this.fotoUrl,
    this.pdfUrl,
  });
  int IdTitulo;
  String titulo;
  String descripcion;
  String fotoUrl;
  String? pdfUrl;

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
        IdTitulo: json["id"] as int,
        titulo: json["titulo"] as String,
        descripcion: json["descripcion"] as String,
        fotoUrl: json["fotoURL"] as String);
  }

  Map<String, dynamic> toJson() {
    return {
      "IdTitulo": IdTitulo,
      "Titulo": titulo,
      "Descripcion": descripcion,
      "FotoUrl": fotoUrl,
      "PdfUrl": pdfUrl,
    };
  }
}
