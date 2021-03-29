import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
                padding: const EdgeInsets.fromLTRB(24, 30, 24, 18),
                child: TextField(
                  decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.black38),
                      hintText: 'Insira seu nome'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 5, 24, 50),
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

const LatLng SOURCE_LOCATION = LatLng(-20.170879853438894, -44.914679816576275);
const LatLng DEST_LOCATION = LatLng(-20.174696417049557, -44.91977605994631);
const double CAMERA_ZOOM = 15;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;
  Set<Marker> _markers = Set<Marker>();

  LatLng currentLocation;
  LatLng destinationLocation;

  @override
  void initState() {
    super.initState();

    // localização atual
    this.setInitialLocation();
    // ícones do marker
    this.setSourceAndDestinationMarkerIcons();
  }

  void setSourceAndDestinationMarkerIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.0), 'images/src_pin.png');

    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.0), 'images/dest_pin.png');
  }

  void setInitialLocation() {
    currentLocation =
        LatLng(SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude);
    destinationLocation =
        LatLng(DEST_LOCATION.latitude, DEST_LOCATION.longitude);
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: SOURCE_LOCATION);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('Postos por perto'),
        ),
        body: Stack(children: [
          Positioned.fill(
            child: GoogleMap(
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                compassEnabled: false,
                tiltGesturesEnabled: false,
                markers: _markers,
                mapType: MapType.normal,
                initialCameraPosition: initialCameraPosition,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);

                  showPinsOnMap();
                }),
          ),
          Positioned(
              top: 30,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(12),
                margin:
                    EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: Offset.zero)
                    ]),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          image: DecorationImage(
                              image: AssetImage('images/profile.jpg'),
                              fit: BoxFit.cover),
                          border: Border.all(color: Colors.green, width: 2)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sidney Campos',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                        Text(
                          'Meu Local',
                          style: TextStyle(color: Colors.green),
                        ),
                      ],
                    )),
                    Icon(
                      Icons.location_pin,
                      color: Colors.green,
                      size: 40,
                    )
                  ],
                ),
              )),
          Positioned(
              // É ESSE AQUI NÃO PERDE VACILÃO
              top: 575,
              left: 0,
              right: 0,
              child: Container(
                //color: Colors.red,
                padding: EdgeInsets.all(12),
                margin:
                    EdgeInsets.only(top: 10, bottom: 10, left: 55, right: 55),
                decoration: BoxDecoration(color: Colors.green,
                    //borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: Offset.zero)
                    ]),
                child: Row(
                  children: [
                    // Container(
                    //   width: 40,
                    //   height: 40,
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(50),
                    //       image: DecorationImage(
                    //           image: AssetImage('images/profile.jpg'),
                    //           fit: BoxFit.cover),
                    //       border: Border.all(color: Colors.green, width: 2)),
                    // ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Encontrar posto com menor Preço',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
                    )),
                  ],
                ),
              ))
        ]));
  }

  void showPinsOnMap() {
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position: currentLocation,
          icon: sourceIcon));

      _markers.add(Marker(
          markerId: MarkerId('destinationPin'),
          position: destinationLocation,
          icon: destinationIcon));
    });
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

// GoogleMap(
// initialCameraPosition:
// CameraPosition(target: LatLng(-20.139167, -44.888056), zoom: 13),
// buildingsEnabled: true,
// )
