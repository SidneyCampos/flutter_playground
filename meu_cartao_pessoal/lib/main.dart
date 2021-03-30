import 'dart:io';
import 'dart:math';

//import 'package:admob_flutter/admob_flutter.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';

import 'ad_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final initFuture = MobileAds.instance.initialize();
  final adState = AdState(initFuture);

  runApp(Provider.value(
    value: adState,
    builder: (context, child) => MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  BannerAd banner;
  InterstitialAd inter;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);
    adState.initialization.then((status) {
      setState(() {
        banner = BannerAd(
            adUnitId: BannerAd
                .testAdUnitId, //'ca-app-pub-5264260497889367/5573721656',
            size: AdSize.banner,
            request: AdRequest(),
            listener: adState.adListener)
          ..load();

        inter = InterstitialAd(
            adUnitId: InterstitialAd
                .testAdUnitId, //'ca-app-pub-5264260497889367/2511077066',
            listener: adState.adListener,
            request: AdRequest())
          ..load();
      });
    });
  }

  // AppOpenAd appOpenAd = AppOpenAd(timeout: Duration(minutes: 30))
  //   ..load(unitId: 'ca-app-pub-3940256099942544/3419835294');

  final picker = ImagePicker();
  File profileImage;

  TextEditingController myControllerNome = TextEditingController();
  TextEditingController myControllerProfissao = TextEditingController();
  TextEditingController myControllerTelefone = TextEditingController();
  TextEditingController myControllerEmail = TextEditingController();
  String profileImageChange = 'images/helena.jpg';
  String name = 'Helena Moraes';
  String profissao = 'BIÓLOGA';
  String telefone = '+55 31 9453-4365';
  String email = 'helena.84@gmail.com';
  Color cor = Colors.teal;
  Color cor300 = Colors.teal[300];
  //TESTES SCREENSHOTS
  final _screenshotController = ScreenshotController();

  Image setProfileImage(String nameImage) {
    if (profileImage == null) return Image.asset(nameImage);
    return Image.file(profileImage);
  }

  TextEditingController setInputDataNome(String text) {
    myControllerNome.text = text;
    return myControllerNome;
  }

  TextEditingController setInputDataProfissao(String text) {
    myControllerProfissao.text = text;
    return myControllerProfissao;
  }

  TextEditingController setInputDataTelefone(String text) {
    myControllerTelefone.text = text;
    return myControllerTelefone;
  }

  TextEditingController setInputDataEmail(String text) {
    myControllerEmail.text = text;
    return myControllerEmail;
  }

  void getText() async {
    PickedFile pickedFile = await picker.getImage(source: ImageSource.gallery);
    profileImage = File(pickedFile.path);
    print(profileImage);
    setState(() {});
  }

  void newData() {
    profileImageChange = 'images/user.png';
    name = 'Nome';
    profissao = 'Profissão';
    telefone = 'Telefone';
    email = 'Email';

    setState(() {
      print('aquiii');
    });
  }

  void cores([int shade = 600]) {
    cor = Colors.primaries[Random().nextInt(Colors.primaries.length)][shade];
    cor300 = Colors.primaries[Random().nextInt(Colors.primaries.length)][300];
    setState(() {});
  }

  void _takeScreenshot() async {
    final imageFile = await _screenshotController.capture(pixelRatio: 3.0);

    setState(() {
      inter.show();
    });

    Share.shareFiles([imageFile.path]);

    //opacityButton(1);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Center(
                child: Container(
                  color: cor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Screenshot(
                        controller: _screenshotController,
                        child: Container(
                          color: cor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: getText,
                                child: CircularProfileAvatar(
                                  '',
                                  child: setProfileImage(profileImageChange),
                                ),
                              ),
                              EditableText(
                                controller: setInputDataNome(name),
                                focusNode: FocusNode(),
                                style: TextStyle(
                                    fontFamily: 'DancingScript',
                                    fontSize: 40,
                                    color: Colors.white),
                                cursorColor: Colors.white,
                                backgroundCursorColor: cor,
                                textAlign: TextAlign.center,
                                textCapitalization: TextCapitalization.words,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              EditableText(
                                controller: setInputDataProfissao(profissao),
                                focusNode: FocusNode(),
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 20,
                                    color: cor300, //cores(300),
                                    letterSpacing: 2.5,
                                    fontWeight: FontWeight.bold),
                                cursorColor: Colors.white,
                                backgroundCursorColor: cor,
                                textAlign: TextAlign.center,
                                textCapitalization:
                                    TextCapitalization.characters,
                              ),
                              SizedBox(
                                height: 20,
                                width: 150,
                                child: Divider(
                                  color: cor300, //cores(300),
                                  thickness: 1,
                                ),
                              ),
                              Card(
                                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  color: Colors.white,
                                  child: ListTile(
                                    leading:
                                        Icon(Icons.phone_android, color: cor),
                                    title: EditableText(
                                      controller:
                                          setInputDataTelefone(telefone),
                                      focusNode: FocusNode(),
                                      style:
                                          TextStyle(fontSize: 16, color: cor),
                                      cursorColor: cor,
                                      backgroundCursorColor: cor,
                                      keyboardType: TextInputType.phone,
                                    ),
                                  )),
                              Card(
                                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  color: Colors.white,
                                  child: ListTile(
                                    leading:
                                        Icon(Icons.alternate_email, color: cor),
                                    title: EditableText(
                                      controller: setInputDataEmail(email),
                                      focusNode: FocusNode(),
                                      style:
                                          TextStyle(fontSize: 16, color: cor),
                                      cursorColor: cor,
                                      backgroundCursorColor: cor,
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                  )),
                              SizedBox(
                                height: 15.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: FloatingActionButton(
                              child: Icon(Icons.add),
                              onPressed: newData,
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: FloatingActionButton(
                              child: Icon(Icons.color_lens),
                              onPressed: cores,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: FloatingActionButton(
                              child: Icon(Icons.share),
                              onPressed: _takeScreenshot,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      if (banner == null)
                        SizedBox(
                          height: 50,
                        )
                      else
                        Container(height: 50, child: AdWidget(ad: banner)),
                    ],
                  ),
                ),
              ),
            )));
  }
}
