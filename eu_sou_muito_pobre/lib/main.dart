import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Admob.initialize();

  runApp(MeuApp());
}

class MeuApp extends StatefulWidget {
  @override
  _MeuAppState createState() => _MeuAppState();
}

class _MeuAppState extends State<MeuApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text("Eu sou muito Pobre"),
        ),
        body: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Image(
                image: NetworkImage(
                    "https://media.giphy.com/media/9BaedF2O7dGlexHmjS/giphy.gif"),
                filterQuality: FilterQuality.high,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            AdmobBanner(
              adUnitId: AdmobBanner.testAdUnitId,
              adSize: AdmobBannerSize.BANNER,
            )
          ],
        ),
      ),
    );
  }
}
