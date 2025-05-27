import 'package:crm_admin/services/qr_service.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:crm_admin/presentation/entry_dialog_widget.dart';

class QrScanPage extends StatefulWidget {
  const QrScanPage({super.key});

  @override
  _QrScanPageState createState() => _QrScanPageState();
}

class _QrScanPageState extends State<QrScanPage> {
  final QrService _service = QrService();
  String? qrText;
  bool _alreadyScanned = false;

  @override
  void initState() {
    super.initState();
    _askPermissions();
  }

  Future<void> _askPermissions() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
    }
  }

  void _onDetect(BarcodeCapture capture) async {
    final barcode = capture.barcodes.first;
    final code = barcode.rawValue;
    if (code != null && !_alreadyScanned) {
      setState(() {
        _alreadyScanned = true;
      });
      final e = await _service.scanQr(code);
      EntryModel entry = EntryModel.fromJson(e);
      await showDialog(
        context: context,
        builder: (context) => EntryDialogWidget(model: entry),
      );
      setState(() => _alreadyScanned = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Сканер QR')),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: MobileScanner(
              onDetect: _onDetect,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text('Отсканируйте QR-код'),
            ),
          ),
        ],
      ),
    );
  }
}
