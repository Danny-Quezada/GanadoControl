import 'package:flutter/material.dart';
import 'package:hackathon_app/ui/config/color_palette.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class QRGeneratePage extends StatelessWidget {
  String cattleId;
  QRGeneratePage({required this.cattleId});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(cattleId,style: TextStyle(color: Colors.black)),
          elevation: 0,
          foregroundColor: Colors.black,
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: QrImageView(
            data: cattleId,
            version: QrVersions.auto,
            size: 200.0,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _shareQRImage(),
          child: Icon(Icons.share,color: Colors.white,),
          backgroundColor: ColorPalette.colorPrincipal,
        ),
      ),
    );
  }

  Future _shareQRImage() async {
    final image = await QrPainter(
      data: cattleId,
      version: QrVersions.auto,
      gapless: false,
     embeddedImageStyle: QrEmbeddedImageStyle(size: const Size(100, 100)),
     color: Colors.black,
     emptyColor: Colors.white,
     
    ).toImageData(400.0); // Generate QR code image data

    final filename = 'qr_code.png';
    final tempDir =
        await getTemporaryDirectory(); // Get temporary directory to store the generated image
    final file = await File('${tempDir.path}/$filename')
        .create(); // Create a file to store the generated image
    var bytes = image!.buffer.asUint8List(); // Get the image bytes
    await file.writeAsBytes(bytes); // Write the image bytes to the file
    final path = await Share.shareFiles([file.path],
        text: 'QR code for ${cattleId}',
        subject: 'QR Code',

        mimeTypes: [
          'image/png'
        ]); // Share the generated image using the share_plus package
    //print('QR code shared to: $path');
  }
}
