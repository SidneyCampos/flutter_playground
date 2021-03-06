import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            backgroundColor: Colors.white, //Color(0x101038),
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.black,
              title: Text('Eu sou muito Rico'),
            ),
            body: Image(
              image: NetworkImage(
                  'https://tenor.com/view/purple-diamond-gem-crystal-pink-spin-gif-17024256.gif'),
              filterQuality: FilterQuality.high,
              width: double.infinity,
              height: double.infinity,
            ),
          )),
    );
