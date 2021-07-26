import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../models/http_exception.dart';

class QrCode {
  final String id;
  final Barcode qrCode;

  QrCode({
    required this.id,
    required this.qrCode,
  });
}

class QrCodes with ChangeNotifier {
  List<QrCode> _qrCodes = [];
  List<QrCode> get qrCodes {
    return [..._qrCodes];
  }

  bool isEmty() {
    return _qrCodes.isEmpty;
  }

  Future<void> fetchAndSetQrCode([bool filterByUser = false]) async {
    var url = Uri.parse(
        'https://scan-qr-code-22164-default-rtdb.firebaseio.com/QRcodes.json');
    try {
      final response = await http.get(url);
      final data = json.decode(response.body) as Map<String, dynamic>;
      url = Uri.parse(
          'https://scan-qr-code-22164-default-rtdb.firebaseio.com/QRcodes.json');
      List<QrCode> loadedQrCodes = [];
      data.forEach((key, qrCode) {
        loadedQrCodes.add(QrCode(
          id: key,
          qrCode: qrCode['qrCode'],
        ));
      });
      _qrCodes = loadedQrCodes;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addQrCodes(Barcode qrCode) async {
    final url = Uri.parse(
        'https://scan-qr-code-22164-default-rtdb.firebaseio.com/QRcodes.json');
    try {
      final response = await http.post(
        url,
        body: json.encode({'qrCode': qrCode}),
      );
      final newQrCode = QrCode(
        id: json.decode(response.body)['name'],
        qrCode: qrCode,
      );
      _qrCodes.add(newQrCode);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
