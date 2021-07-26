import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/qr_code.dart';
import '../widgets/qr_code_item.dart';
import 'scanner_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var isEmty = true;

  @override
  void initState() {
    Provider.of<QrCodes>(context, listen: false).fetchAndSetQrCode();
    isEmty = Provider.of<QrCodes>(context, listen: false).isEmty();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR'),
      ),
      body: isEmty
          ? Center(
              child: ScanButton(),
            )
          : FutureBuilder(
              future: Provider.of<QrCodes>(context, listen: false)
                  .fetchAndSetQrCode(),
              builder: (ctx, dataSnapshot) {
                if (dataSnapshot.connectionState == ConnectionState.waiting)
                  return Center(child: CircularProgressIndicator());
                else if (dataSnapshot.error == null)
                  return Consumer<QrCodes>(
                      builder: (ctx, qrCode, child) => ListView.builder(
                            itemCount: qrCode.qrCodes.length,
                            itemBuilder: (ctx, i) => Column(
                              children: [
                                QrCodeItem(qrCode.qrCodes[i].qrCode),
                                Divider(),
                              ],
                            ),
                          ));
                else
                  return Center(
                    child: Text('An error occurred!'),
                  );
              },
            ),
    );
  }
}

class ScanButton extends StatelessWidget {
  const ScanButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: 100, height: 70),
      child: ElevatedButton(
        child: Text('Scan', style: TextStyle(fontSize: 20)),
        onPressed: () {
          Navigator.of(context).pushNamed(ScannerScreen.routeName);
        },
      ),
    );
  }
}
