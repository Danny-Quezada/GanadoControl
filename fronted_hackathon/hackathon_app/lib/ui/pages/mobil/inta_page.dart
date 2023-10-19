import 'package:flutter/material.dart';
import 'package:hackathon_app/domain/models/Entities/documents.dart';
import 'package:hackathon_app/provider/document_provider.dart';
import 'package:hackathon_app/ui/widgets/custom_card_widget.dart';
import 'package:hackathon_app/ui/widgets/farm_card.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class IntaPage extends StatelessWidget {
  const IntaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Documentos INTA",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: DocumentsList(),
          ),
        ],
      ),
    );
  }
}

class DocumentsList extends StatelessWidget {
  const DocumentsList({super.key});

  @override
  Widget build(BuildContext context) {
    final documentProvider =
        Provider.of<DocumentProvider>(context, listen: false);
    documentProvider.getDocument();
    return Consumer<DocumentProvider>(
      builder: (context, DocumentProviderConsumer, child) {
        if (documentProvider.list == null) {
          return Container();
        }
        return ListView.builder(
          itemCount: documentProvider.list!.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: const EdgeInsets.only(top: 20),
                child: CustomCardWidget([],
                    function: () => pdfDocument(
                        context, documentProvider.list![index].IdTitulo),
                    urlImage: documentProvider.list![index].fotoUrl,
                    title: documentProvider.list![index].titulo,
                    description: documentProvider.list![index].descripcion,
                    radius: 12,
                    onLongPress: () {}));
          },
        );
      },
    );
  }

  void pdfDocument(BuildContext context, int IdDocumento) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return PdfDocument(
          IdDocument: IdDocumento,
        );
      },
    ));
  }
}

class PdfDocument extends StatelessWidget {
  PdfDocument({super.key, required this.IdDocument});

  int IdDocument;

  @override
  Widget build(BuildContext context) {
    final documentProvider =
        Provider.of<DocumentProvider>(context, listen: false);
    return FutureBuilder<String>(
      future: documentProvider.getPdfByDocument(IdDocument),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Muestra un indicador de carga mientras espera.
        } else {
          print(snapshot..data);
          // return Container();
          return SfPdfViewer.network(
            snapshot.data!,
            enableDoubleTapZooming: true,
          );
        }
      },
    );
  }
}
