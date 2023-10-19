import 'package:hackathon_app/domain/interfaces/imodel.dart';
import 'package:hackathon_app/domain/models/Entities/documents.dart';

abstract class IDocumentModel extends IModel<Document> {
  Future<List<Document>> getDocument();

  Future<String> getPdf(int IdDocument);
}
