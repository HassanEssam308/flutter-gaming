import 'package:flutter/material.dart';
import 'package:flutter_gaming/screens/matching_images_screen.dart';
import 'package:flutter_gaming/widgets/count_up_timer.dart';


import 'dart:async';
import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Gaming',
      theme: ThemeData(
       colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MatchingImagesGameScreen()
   );
  }
}

