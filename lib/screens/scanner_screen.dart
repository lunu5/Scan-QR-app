import 'package:flutter/material.dart';
import '../widgets/scanner.dart';

class ScannerScreen extends StatelessWidget {
  static const routeName = '/scanner';

  const ScannerScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scanner'),
      ),
      body: Scanner(),
    );
  }
}