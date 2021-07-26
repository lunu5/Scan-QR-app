import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class QrCodeItem extends StatelessWidget {
  final qrcode;

  QrCodeItem(this.qrcode);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Text(
        'Barcode Type: ${describeEnum(qrcode!.format)}   Data: ${qrcode!.code}',
        style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColor),
        textAlign: TextAlign.center,
      ),
    );
  }
}
