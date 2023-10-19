import 'package:hackathon_app/app_core/iservices/iservices.dart';
import 'package:hackathon_app/domain/models/Entities/documents.dart';

abstract class IDocumentServices extends IServices<Document> {
  Future<List<Document>> getDocument();

  Future<String> getPdf(int IdDocument);
}
