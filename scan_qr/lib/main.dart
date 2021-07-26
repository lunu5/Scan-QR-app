import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/scanner_screen.dart';
import 'providers/qr_code.dart';
import 'screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: QrCodes(),
      child: MaterialApp(
        title: 'Scan QR',
        theme: ThemeData(
            primarySwatch: Colors.red,
            accentColor: Colors.pink,
            fontFamily: 'Lato',
            elevatedButtonTheme: ElevatedButtonThemeData(
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
            ),
            textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                //backgroundColor: MaterialStateProperty.all<Color>(Colors.pink),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.pink),
                elevation: MaterialStateProperty.resolveWith<double>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) return 16;
                  return 0;
                }),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                    side: BorderSide(color: Colors.pink, width: 0.1),
                  ),
                ),
              ),
            )),
        //home: HomeScreen(),
        initialRoute: HomeScreen.routeName,
        routes: {
          HomeScreen.routeName: (ctx) => HomeScreen(),
          ScannerScreen.routeName: (ctx) => ScannerScreen(),
        },
      ),
    );
  }
}
