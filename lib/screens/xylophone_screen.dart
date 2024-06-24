import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class Xylophone extends StatelessWidget {
  Xylophone({super.key});
 final List<Color> colors = [
   Colors.indigo,
   Colors.greenAccent,
   Colors.amberAccent,
   Colors.deepOrangeAccent,
    Colors.lightBlue,
   Colors.redAccent,
   Colors.purple
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: List.generate(colors.length, (index) {
            return drawerButton(index + 1, colors[index]);
          })),
    ));
  }

  Widget drawerButton(int note, Color color) {
    return Expanded(
      child: TextButton(
        onPressed: () async {
          final player = AudioPlayer();
          await player.play(AssetSource('audio/note$note.mp3'));
        },
        style: TextButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        child: const Text(""),
      ),
    );
  }
}
