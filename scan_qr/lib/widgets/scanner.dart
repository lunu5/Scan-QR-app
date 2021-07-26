import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../providers/qr_code.dart';

class Scanner extends StatefulWidget {
  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var scanArea =
        (width < 500 || height < 500) ? math.min(width, height) * 0.5 : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Theme.of(context).primaryColor,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    bool scanned = false;
    controller.scannedDataStream.listen((scanData) {
      if (!scanned) {
        scanned = true;
        setState(() {
          result = scanData;
          Provider.of<QrCodes>(context, listen: false).addQrCodes(scanData);
        });
        Navigator.of(context).pop();
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No Permission')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(flex: 6, child: _buildQrView(context)),
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black87,
                        Colors.transparent,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: result != null
                      ? Text(
                          'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                          textAlign: TextAlign.center,
                        )
                      : Text(
                          'Scan a code',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: TextButton.icon(
                      onPressed: () async {
                        await controller?.toggleFlash();
                        setState(() {});
                      },
                      icon: Icon(Icons.flash_on),
                      label: FutureBuilder(
                        future: controller?.getFlashStatus(),
                        builder: (context, snapshot) => Text(
                            'Flash: ${snapshot.data}',
                            style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextButton.icon(
                      onPressed: () async {
                        await controller?.flipCamera();
                        setState(() {});
                      },
                      icon: Icon(Icons.flip_camera_android),
                      label: FutureBuilder(
                        future: controller?.getCameraInfo(),
                        builder: (context, snapshot) => snapshot.data != null
                            ? Text('${describeEnum(snapshot.data!)} cam',
                                style: TextStyle(fontSize: 16))
                            : Text('loading', style: TextStyle(fontSize: 18)),
                      ),
                    ),
                  )
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: <Widget>[
              //     Container(
              //       margin: EdgeInsets.all(8),
              //       child: ElevatedButton(
              //         onPressed: () async {
              //           await controller?.pauseCamera();
              //         },
              //         child: Text('pause', style: TextStyle(fontSize: 20)),
              //       ),
              //     ),
              //     Container(
              //       margin: EdgeInsets.all(8),
              //       child: ElevatedButton(
              //         onPressed: () async {
              //           await controller?.resumeCamera();
              //         },
              //         child: Text('resume', style: TextStyle(fontSize: 20)),
              //       ),
              //     )
              //   ],
              // ),
            ],
          ),
        ),
        // Expanded(
        //   flex: 1,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //     children: [
        //       Expanded(
        //         flex: 1,
        //         child: RaisedButton(
        //           onPressed: () => controller.flipCamera(),
        //           color: Theme.of(context).accentColor,
        //           child: Row(
        //             children: [
        //               Icon(Icons.flip_camera_android),
        //               Text('Flip camera'),
        //             ],
        //           ),
        //           elevation: 0,
        //           materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        //         ),
        //       ),
        //       Expanded(
        //         flex: 1,
        //         child: RaisedButton(
        //           onPressed: () => controller.toggleFlash(),
        //           color: Theme.of(context).accentColor,
        //           child: Row(
        //             children: [
        //               Icon(Icons.flash_on),
        //               Text('Flash'),
        //             ],
        //           ),
        //           elevation: 0,
        //           materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
