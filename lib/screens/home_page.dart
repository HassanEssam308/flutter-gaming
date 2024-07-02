import 'package:flutter/material.dart';
import 'package:flutter_gaming/screens/matching_images_screen.dart';
import 'package:flutter_gaming/screens/word_puzzle_game.dart';
import 'package:flutter_gaming/screens/xylophone_screen.dart';

import '../models/item_bottom_navigation_model.dart';

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
          title: Text(
            titleOfPage,
          ),
          centerTitle: true,
        ),
        body: pages[pageIndex],
        bottomNavigationBar: Container(
          height: 60,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              drawerItemInBottomNavigation(
                ItemBottomNavigationModel(
                    pageIndex: 0,
                    pathOfImage: "assets/images/icons/match_image.png",
                    titleOfPage: "Match Images Game"),
              ),
              drawerItemInBottomNavigation(
                ItemBottomNavigationModel(
                    pageIndex: 1,
                    pathOfImage:"assets/images/icons/word_puzzle.png",
                    titleOfPage: "Word Puzzle Game"),
              ),
              drawerItemInBottomNavigation(
                ItemBottomNavigationModel(
                    pageIndex: 2,
                    pathOfImage:"assets/images/icons/xylophone.png",
                    titleOfPage: "Xylophone Game"),
              ),
            ],
          ),
        ),
      ),
    );
  }

 Widget drawerItemInBottomNavigation(
      ItemBottomNavigationModel itemBottomNavigationModel) {
    int index=itemBottomNavigationModel.pageIndex;
   return InkWell(
      onTap: () {
        setState(() {
          titleOfPage = itemBottomNavigationModel.titleOfPage;
          pageIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          border: pageIndex == index
              ? const Border.symmetric(
                  horizontal: BorderSide(color: Colors.black, width: 3))
              : const Border.symmetric(horizontal: BorderSide.none),
        ),
        child: Image.asset(
          itemBottomNavigationModel.pathOfImage,
          width: pageIndex == index ? 45 : 30,
          height: pageIndex == index ? 45 : 30,
          opacity: AnimationController(
              vsync: this, value: pageIndex == index ? 1 : .5,),
        ),
      ),
    );
  }
}
