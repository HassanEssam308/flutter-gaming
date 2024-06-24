import 'package:flutter/material.dart';
import 'package:flutter_gaming/screens/matching_images_screen.dart';
import 'package:flutter_gaming/screens/word_puzzle_game.dart';
import 'package:flutter_gaming/screens/xylophone_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int pageIndex = 0;
  String titleOfPage = "Match Images Game";

  final pages = [
    const MatchingImagesGameScreen(),
    const WordPuzzleGame(),
    Xylophone(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          title:  Text(
            titleOfPage,
          ),
          centerTitle: true,
        ) ,
        body: pages[pageIndex],
        bottomNavigationBar: Container(
          height: 60,
          decoration:  const BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    titleOfPage="Match Images Game";
                    pageIndex = 0;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration:  BoxDecoration(
                    border:pageIndex==0?
                    const Border.symmetric(horizontal:BorderSide(color: Colors.black ,width: 3,)):
                    const Border.symmetric(horizontal:BorderSide.none),
                  ),
                  child: Image.asset("assets/images/icons/match_image.png",
                      width:pageIndex==0? 45:30,
                      height: pageIndex==0? 45:30,
                      opacity:AnimationController(
                          vsync: this,
                          value: pageIndex==0?1:.5
                      ),
                     ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    titleOfPage="Word Puzzle Game";
                    pageIndex = 1;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration:  BoxDecoration(
                    border:pageIndex==1?
                    const Border.symmetric(horizontal:BorderSide(color: Colors.black ,width: 3)):
                    const Border.symmetric(horizontal:BorderSide.none),
                  ),
                  child: Image.asset("assets/images/icons/word_puzzle.png",
                      width:pageIndex==1? 45:30,
                      height: pageIndex==1? 45:30,
                      opacity:AnimationController(
                          vsync: this,
                          value:pageIndex==1?1:.5
                      ),
                     ),
                ),
              ),
               InkWell(
                onTap: () {
                  setState(() {
                    titleOfPage="Xylophone Game";
                    pageIndex = 2;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration:  BoxDecoration(
                    border:pageIndex==2?
                    const Border.symmetric(horizontal:BorderSide(color: Colors.black ,width: 3)):
                    const Border.symmetric(horizontal:BorderSide.none),
                  ),
                  child: Image.asset("assets/images/icons/xylophone.png",
                      width:pageIndex==2? 45:30,
                      height: pageIndex==2? 45:30,
                      opacity:AnimationController(
                          vsync: this,
                          value: pageIndex==2?1:.5
                      ),
                     ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
