import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_provider_utilities/flutter_provider_utilities.dart';
import 'package:hackathon_app/domain/models/Entities/cattle.dart';
import 'package:hackathon_app/provider/cattle_provider.dart';
import 'package:hackathon_app/ui/pages/mobil/cow_information_page.dart';
import 'package:hackathon_app/ui/pages/mobil/initial_page.dart';
import 'package:hackathon_app/ui/widgets/flushbar_widget.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScannerPage extends StatefulWidget {
  QRScannerPage({super.key, required this.IdFarm});

  int IdFarm;

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Cattle? cattle;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return MessageListener<CattleProvider>(
      showInfo: (info) {},
      showError: (error) {
        flushbarWidget(
            context: context, title: "Error", message: error, error: true);
      },
      child: cattle != null
          ? CowInformationPage(
              cattle: cattle!,
              IdFarm: widget.IdFarm,
            )
          : Scaffold(
              body: Column(
                children: <Widget>[
                  Expanded(flex: 4, child: _buildQrView(context)),
                ],
              ),
            ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: 300),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      final cattleProvider =
          Provider.of<CattleProvider>(context, listen: false);

      if (scanData != null) {
        if (context.mounted) {
          Cattle? getCattle =
              await cattleProvider.getCattleById(scanData!.code!);
          cattle = getCattle;
        }
      }
      setState(() {});
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
