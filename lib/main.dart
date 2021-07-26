import 'package:flutter/material.dart';
import './screens/scanner_screen.dart';
import 'screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scan QR',
      theme: ThemeData(
          primarySwatch: Colors.red,
          accentColor: Colors.pink,
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(primary: Colors.pink),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.pink),
              elevation: MaterialStateProperty.resolveWith<double>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) return 16;
                return 0;
              }),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                  side: BorderSide(color: Colors.red),
                ),
              ),
            ),
          )),
      home: HomeScreen(),
      routes: {
        ScannerScreen.routeName: (ctx) => ScannerScreen(),
      },
    );
  }
}
