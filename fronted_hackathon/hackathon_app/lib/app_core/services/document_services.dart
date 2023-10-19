import 'package:hackathon_app/app_core/iservices/idocument_services.dart';
import 'package:hackathon_app/domain/interfaces/document_model.dart';
import 'package:hackathon_app/domain/models/Entities/documents.dart';

class DocumentServices implements IDocumentServices {
  IDocumentModel iDocumentModel;

  DocumentServices({required this.iDocumentModel});

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
  Future<List<Document>> getDocument() async {
    return await iDocumentModel.getDocument();
  }

  @override
  Future<String> getPdf(int IdDocument) async {
    return await iDocumentModel.getPdf(IdDocument);
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
}
