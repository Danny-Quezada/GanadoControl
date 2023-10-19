import 'package:flutter/material.dart';
import 'package:flutter_provider_utilities/flutter_provider_utilities.dart';
import 'package:hackathon_app/app_core/iservices/idocument_services.dart';
import 'package:hackathon_app/domain/models/Entities/documents.dart';
import 'package:hackathon_app/provider/igeneric_provider.dart';

class DocumentProvider extends ChangeNotifier
    with IGenericProvider<Document>, MessageNotifierMixin {
  @override
  void doNull() {
    t = null;
    list = null;
  }

  IDocumentServices _iDocumentServices;

  DocumentProvider({required IDocumentServices iDocumentServices})
      : _iDocumentServices = iDocumentServices;

  Future<List<Document>> getDocument() async {
    if (list != null) {
      return list!;
    }

    list = await _iDocumentServices.getDocument();
    notifyListeners();
    return list!;
  }

  Future<String> getPdfByDocument(int IdDocument) async {
    return await _iDocumentServices.getPdf(IdDocument);
  }
}
