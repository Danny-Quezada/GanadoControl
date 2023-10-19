import 'package:dio/dio.dart';
import 'package:hackathon_app/domain/constant.dart';
import 'package:hackathon_app/domain/interfaces/document_model.dart';
import 'package:hackathon_app/domain/models/Entities/documents.dart';

class DocumentoRepository implements IDocumentModel {
  Dio dio = Dio();

  @override
  Future<int> create(Document t) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<bool> delete(Document t) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<Document>> read() {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<bool> update(Document t) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<List<Document>> getDocument() async {
    List<Document> documents = [];

    try {
      var response = await dio.get("${Constant.getDocuments}");
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        if (data.length == 0) {
          return [];
        }
        data.forEach((element) {
          documents.add(Document.fromJson(element));
        });
        return documents;
      }
      throw Exception("Hubo un error, intente nuevamente.");
    } catch (e) {
      throw Exception("Error en el servidor.");
    }
  }

  @override
  Future<String> getPdf(int IdDocument) async {
    try {
      var response = await dio.get("${Constant.getPdfbyDocument}/$IdDocument");
      if (response.statusCode == 200) {
        return response.data;
      }
      throw Exception("Hubo un error, intente nuevamente.");
    } catch (e) {
      throw Exception("Error en el servidor.");
    }
  }
}
