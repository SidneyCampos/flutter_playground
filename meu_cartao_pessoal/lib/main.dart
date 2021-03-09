import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:image_picker/image_picker.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final picker = ImagePicker();
  File _image;

  Future getImage() async{
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
  }

  
  //String teste = 'images/user.png';


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Colors.teal[600],
            // appBar: AppBar(
            //   backgroundColor: Colors.teal[900],
            //   centerTitle: true,
            //   title: Text("Meu cartão pessoal"),
            // ),
            body: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: ,
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage(teste),
                        //foregroundImage: AssetImage("images/playstore_icon.png"),
                      ),
                    ),
                    Text(
                      "Sidney Campos",
                      style: TextStyle(
                          fontFamily: 'DancingScript',
                          fontSize: 40,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text("FLUTTER DEVELOPER",
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 20,
                            color: Colors.teal[300],
                            letterSpacing: 2.5,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 20,
                      width: 150,
                      child: Divider(
                        color: Colors.teal[300],
                        thickness: 1,
                      ),
                    ),
                    Card(
                        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        color: Colors.white,
                        child: ListTile(
                          leading: Icon(Icons.phone, color: Colors.teal[600]),
                          title: Text(
                            '+55 37 98807 - 8612',
                            style: TextStyle(
                                fontSize: 16, color: Colors.teal[600]),
                          ),
                        )),
                    Card(
                        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        color: Colors.white,
                        child: ListTile(
                          leading: Icon(Icons.mail, color: Colors.teal[600]),
                          title: Text(
                            'sidneycampos22@gmail.com',
                            style: TextStyle(
                                fontSize: 16, color: Colors.teal[600]),
                          ),
                        )),
                  ],
                ),
              ),
            )));
  }
}

// class MyApp extends StatelessWidget {
//   final _image = null;
//   final picker = ImagePicker();
//   String teste = 'images/user.png';
//
//   void getAvatarImage() {
//     picker.getImage(source: ImageSource.gallery);
//     teste = picker.toString();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//             backgroundColor: Colors.teal[600],
//             // appBar: AppBar(
//             //   backgroundColor: Colors.teal[900],
//             //   centerTitle: true,
//             //   title: Text("Meu cartão pessoal"),
//             // ),
//             body: SafeArea(
//               child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     GestureDetector(
//                       child: CircleAvatar(
//                         radius: 50.0,
//                         backgroundColor: Colors.white,
//                         backgroundImage: AssetImage(teste),
//                         //foregroundImage: AssetImage("images/playstore_icon.png"),
//                       ),
//                       onTap: getAvatarImage,
//                     ),
//                     Text(
//                       "Sidney Campos",
//                       style: TextStyle(
//                           fontFamily: 'DancingScript',
//                           fontSize: 40,
//                           color: Colors.white),
//                     ),
//                     SizedBox(
//                       height: 10.0,
//                     ),
//                     Text("FLUTTER DEVELOPER",
//                         style: TextStyle(
//                             fontFamily: 'Roboto',
//                             fontSize: 20,
//                             color: Colors.teal[300],
//                             letterSpacing: 2.5,
//                             fontWeight: FontWeight.bold)),
//                     SizedBox(
//                       height: 20,
//                       width: 150,
//                       child: Divider(
//                         color: Colors.teal[300],
//                         thickness: 1,
//                       ),
//                     ),
//                     Card(
//                         margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
//                         color: Colors.white,
//                         child: ListTile(
//                           leading: Icon(Icons.phone, color: Colors.teal[600]),
//                           title: Text(
//                             '+55 37 98807 - 8612',
//                             style: TextStyle(
//                                 fontSize: 16, color: Colors.teal[600]),
//                           ),
//                         )),
//                     Card(
//                         margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
//                         color: Colors.white,
//                         child: ListTile(
//                           leading: Icon(Icons.mail, color: Colors.teal[600]),
//                           title: Text(
//                             'sidneycampos22@gmail.com',
//                             style: TextStyle(
//                                 fontSize: 16, color: Colors.teal[600]),
//                           ),
//                         )),
//                   ],
//                 ),
//               ),
//             )));
//   }
// //}
