import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Than we setup preferred orientations,
  // and only after it finished we run our app
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'LoginView',
      routes: {
        'LoginView': (context) => LoginView(),
        'MapView': (context) => GoogleMapScreen()
      },
    );
  }
}

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(250.0),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 24, 0, 20),
            child: SafeArea(
              child: Image.asset(
                'images/imagem_titulo.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 30, 5, 18),
                child: TextField(
                  decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.black38),
                      hintText: 'Insira seu nome'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 5, 5, 50),
                child: TextField(
                  decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.black38),
                      hintText: 'Insira seu Email'),
                ),
              ),
              SignInButton(
                Buttons.Email,
                onPressed: () {
                  Navigator.pushNamed(context, 'MapView');
                },
              ),
              SignInButton(
                Buttons.GoogleDark,
                onPressed: () {},
              ),
              SignInButton(
                Buttons.Facebook,
                onPressed: () {},
              ),
            ],
          ),
        ));
  }
}

class GoogleMapScreen extends StatefulWidget {
  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  static const String _API_KEY = '{{AIzaSyA-aBMRUYH6hV7p0_OUcw1nPtMDkwVboa4}}';
  List<Marker> markers = <Marker>[];
  // 1
  void searchNearby(double latitude, double longitude) async {
    setState(() {
      markers.clear(); // 2
    });
    // 3
    String url =
        '$baseUrl?key=$_API_KEY&location=$latitude,$longitude&radius=10000&keyword=${widget.keyword}';
    print(url);
    // 4
    final response = await http.get(url);
    // 5
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _handleResponse(data);
    } else {
      throw Exception('An error occurred getting places nearby');
    }
    setState(() {
      searching = false; // 6
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Postos por perto'),
        ),
        body: GoogleMap(
          initialCameraPosition:
              CameraPosition(target: LatLng(-20.139167, -44.888056), zoom: 13),
        ));
  }
}

// Container(
//   child: Expanded(
//     child: Image.asset(
//       'images/textura.png',
//       fit: BoxFit.fill,
//       alignment: Alignment.center,
//     ),
//   ),
// )

//class MapView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Postos por perto'),
//       ),
//       body: Center(
//         child: Text('Oi fdp'),
//       ),
//     );
//   }
// }
