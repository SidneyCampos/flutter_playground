import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  // For lock orientation
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // FUNÇÕES

  AudioCache player = AudioCache(prefix: '/assets/');

  void playing() {
    player.play('a.mp3');
    setState(() {});
  }

  Card pianoKeys(Color keyColor, String keyNote, String keyName) {
    return Card(
      margin: EdgeInsets.all(0),
      color: keyColor,
      child: ListTile(
        leading: Text(keyNote),
        onTap: playing,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              pianoKeys(Colors.deepPurple, 'A', 'assets/a.wav'),
              pianoKeys(Colors.blue, 'Bm', 'assets/bb.wav'),
              pianoKeys(Colors.lightBlue, 'B', 'assets/b.wav'),
              pianoKeys(Colors.cyan, 'C', 'assets/c.wav'),
              pianoKeys(Colors.teal, 'C#', 'assets/c#.wav'),
              pianoKeys(Colors.green, 'D', 'assets/d.wav'),
              pianoKeys(Colors.lightGreen, 'Em', 'assets/eb.wav'),
              pianoKeys(Colors.lime, 'F', 'assets/f.wav'),
              pianoKeys(Colors.yellow, 'F#', 'assets/f#.wav'),
              pianoKeys(Colors.amber, 'G', 'assets/g.wav'),
              pianoKeys(Colors.orange, 'G#', 'assets/g#.wav'),
              pianoKeys(Colors.deepPurple, 'A', 'assets/a.wav'),
            ],
          ),
        ),
      ),
    );
  }
}
