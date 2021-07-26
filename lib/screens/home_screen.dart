import 'package:flutter/material.dart';
import 'scanner_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints.tightFor(width: 100, height: 70),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.pink),
              elevation: MaterialStateProperty.resolveWith<double>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) return 16;
                return 0;
              }),
              tapTargetSize: MaterialTapTargetSize.padded,
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(color: Colors.red),
                ),
              ),
            ),
            child: Text('Scan'),
            onPressed: () {
              Navigator.of(context).pushNamed(ScannerScreen.routeName);
            },
          ),
        ),
      ),
    );
  }
}
