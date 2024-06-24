import 'dart:math';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';

import 'models/match_images_model.dart';

class ImagesRepository{
  final List<MatchImagesModel> _imagesOfAnimals = [
    MatchImagesModel(path:'assets/images/animals/octo.png',isOpen: true,flipOnTouch: true ),
    MatchImagesModel(path:'assets/images/animals/fish.png',isOpen: true,flipOnTouch: true ),
    MatchImagesModel(path:'assets/images/animals/peacock.png',isOpen: true,flipOnTouch: true ),
    MatchImagesModel(path:'assets/images/animals/rabbit.png',isOpen: true,flipOnTouch: true ),
    MatchImagesModel(path:'assets/images/animals/shark.png',isOpen: true ,flipOnTouch: true),
    MatchImagesModel(path:'assets/images/animals/whale.png',isOpen: true,flipOnTouch: true ),

  ];

  List<MatchImagesModel> getImagesForGame() {
    List<MatchImagesModel> imagesForGame = List.from(_imagesOfAnimals)
      ..addAll(_imagesOfAnimals);
    imagesForGame.shuffle(Random());
    return imagesForGame;
  }
  List<GlobalKey<FlipCardState>> getCardStateKeys() {

    List<GlobalKey<FlipCardState>> cardStateKeys =[];

    for (int i = 0; i < 12; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
    }

    return cardStateKeys;
  }
}