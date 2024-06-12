import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
class Xylophone extends StatelessWidget {
  Xylophone({super.key});
  List<Color>colors =[Colors.redAccent,Colors.orangeAccent,
    Colors.amberAccent, Colors.green ,Colors.lightBlue,Colors.blueAccent,Colors.purple];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: List.generate(colors.length, (index){
          return drawerButton(index+1,colors[index]);
        })
      ),
    ));
  }

Widget  drawerButton(int note ,Color color) {
    return Expanded(
      child: TextButton(
        onPressed: () async {
          final player = AudioPlayer();
          await player.play(AssetSource('audio/note$note.wav'));
        },
        style: TextButton.styleFrom(
          backgroundColor:color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        child: Text(""),
      ),
    );
}
}
