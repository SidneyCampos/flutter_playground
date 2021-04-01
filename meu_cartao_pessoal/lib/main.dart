import 'dart:io';
import 'dart:math';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meu_cartao_pessoal/mascaras.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';

import 'ad_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final initFuture = MobileAds.instance.initialize();
  final adState = AdState(initFuture);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
      (value) => runApp(Provider.value(
          value: adState, builder: (context, child) => MyApp())));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  BannerAd banner;
  InterstitialAd inter;
  final _formKey = GlobalKey<FormState>();
  final _telefone = TextEditingController(text: '(37) 99985-7854');
  final _email = TextEditingController(text: 'HelenaMoraes.84@gmail.com');
  final _nome = TextEditingController(text: 'Helena Moraes');
  final _profissao = TextEditingController(text: 'BIÓLOGA');

  final picker = ImagePicker();
  File profileImage;

  TextEditingController myControllerNome = TextEditingController();
  TextEditingController myControllerProfissao = TextEditingController();
  TextEditingController myControllerTelefone = TextEditingController();
  TextEditingController myControllerEmail = TextEditingController();
  String profileImageChange = 'images/helena.jpg';
  Color cor = Colors.teal;
  Color cor300 = Colors.teal[300];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);
    adState.initialization.then((status) {
      setState(() {
        banner = BannerAd(
            adUnitId: 'ca-app-pub-5264260497889367/5573721656',
            size: AdSize.banner,
            request: AdRequest(),
            listener: adState.adListener)
          ..load();

        inter = InterstitialAd(
            adUnitId: 'ca-app-pub-5264260497889367/2511077066',
            listener: adState.adListener,
            request: AdRequest())
          ..load();
      });
    });
  }

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
    print(myControllerProfissao.text);
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
    _telefone.clear();
    _email.clear();
    _nome.clear();
    _profissao.clear();
    setState(() {});
  }

  void cores() {
    cor = Colors.primaries[Random().nextInt(Colors.primaries.length)];
    cor300 = Colors.primaries[Random().nextInt(Colors.primaries.length)][300];
    print('aquiii');
    setState(() {});
  }

  void _takeScreenshot() async {
    final imageFile = await _screenshotController.capture(pixelRatio: 3.0);

    Share.shareFiles([imageFile.path]);

    setState(() {
      inter.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Container(
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
                            Form(
                              // É AQUI --------------------------------
                              child: TextField(
                                onTap: () {
                                  setState(() {
                                    _nome.clear();
                                  });
                                },
                                textAlign: TextAlign.center,
                                cursorColor: cor300,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'DancingScript',
                                  fontSize: 40,
                                ),
                                controller: _nome,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                    right: 40,
                                  ), // add padding to adjust text
                                  isDense: true,
                                  hintText: "Nome",
                                  hintStyle: TextStyle(color: Colors.black26),

                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(
                                        top: 10,
                                        left: 10), // add padding to adjust icon
                                    child: Icon(
                                      Icons.phone_android,
                                      color: cor,
                                      size: 28,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Form(
                              // É AQUI --------------------------------
                              child: TextField(
                                onTap: () {
                                  setState(() {
                                    _profissao.clear();
                                  });
                                },
                                textAlign: TextAlign.center,
                                cursorColor: cor300,
                                style: TextStyle(
                                    color: cor300,
                                    fontFamily: 'Roboto',
                                    fontSize: 20,
                                    letterSpacing: 2.5),
                                controller: _profissao,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.name,
                                textCapitalization:
                                    TextCapitalization.characters,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                    right: 40,
                                  ), // add padding to adjust text
                                  isDense: true,
                                  hintText: "Profissão",
                                  hintStyle: TextStyle(color: Colors.black26),

                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(
                                        top: 10,
                                        left: 10), // add padding to adjust icon
                                    child: Icon(
                                      Icons.phone_android,
                                      color: cor,
                                      size: 28,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                              width: 150,
                              child: Divider(
                                color: cor300, //cores(300),
                                thickness: 1,
                              ),
                            ),
                            Container(
                              height: 77,
                              child: Card(
                                margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                color: Colors.white,
                                child: Form(
                                  key: _formKey,
                                  child: TextField(
                                    onTap: () {
                                      setState(() {
                                        _telefone.clear();
                                      });
                                    },
                                    textAlign: TextAlign.start,
                                    inputFormatters: [maskTelCel],
                                    cursorColor: cor300,
                                    style: TextStyle(color: cor),
                                    controller: _telefone,
                                    textInputAction: TextInputAction.done,
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          top: 20,
                                          right:
                                              140), // add padding to adjust text
                                      isDense: true,
                                      hintText: "Telefone",

                                      prefixIcon: Padding(
                                        padding: EdgeInsets.only(
                                            top: 10,
                                            left: 10,
                                            right:
                                                10), // add padding to adjust icon
                                        child: Icon(
                                          Icons.phone_android,
                                          color: cor,
                                          size: 28,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 77,
                              child: Card(
                                margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                color: Colors.white,
                                child: TextField(
                                  onTap: () {
                                    setState(() {
                                      _email.clear();
                                    });
                                  },
                                  textAlign: TextAlign.start,
                                  //inputFormatters: [maskTelCel],
                                  cursorColor: cor300,
                                  style: TextStyle(color: cor),
                                  controller: _email,
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        top: 20,
                                        left: 30), // add padding to adjust text
                                    isDense: true,
                                    hintText: "Email",

                                    prefixIcon: Padding(
                                      padding: EdgeInsets.only(
                                          top: 10,
                                          left: 10,
                                          right:
                                              10), // add padding to adjust icon
                                      child: Icon(
                                        Icons.alternate_email,
                                        color: cor,
                                        size: 28,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
          ),
        ),
      ),
    );
  }
}
