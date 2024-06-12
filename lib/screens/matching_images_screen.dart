import 'dart:async';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import '../models/images_repository.dart';
import '../models/match_images_model.dart';
import '../widgets/count_up_timer.dart';
import '../widgets/widget_question_mark.dart';

class MatchingImagesGameScreen extends StatefulWidget {
  const MatchingImagesGameScreen({super.key});

  @override
  State<MatchingImagesGameScreen> createState() =>
      _MatchingImagesGameScreenState();
}

class _MatchingImagesGameScreenState extends State<MatchingImagesGameScreen> {
  late List<MatchImagesModel> _cardImgs;
  late List<GlobalKey<FlipCardState>> _cardStateKeys;
  int matchesFound = 0;
  String titleOfPage = "Match Images Game";
  bool isIgnoreClick = false;
  List<int> selectedIndices = [];
  bool _startTimer=false;
  bool finish =false;
  int tries=0;
  String time='';
  CountUpTimer? countUpTimer;

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    _cardImgs = [];
    _cardStateKeys = [];
    titleOfPage = "Match Images Game";
    matchesFound = 0;
    selectedIndices=[];
    isIgnoreClick = false;
    _startTimer=false;
     finish =false;
    countUpTimer=null;
    tries=0;
    _cardStateKeys = ImagesRepository().getCardStateKeys();
    _cardImgs = ImagesRepository().getImagesForGame();
    startGameAfterMilliseconds(10);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Center(child: Text(titleOfPage)),
        ),
        body: finish
            ?  youWin()
            : IgnorePointer(
                ignoring: isIgnoreClick,
                child: playGame(),
              ),
      ),
    );
  }

  Widget youWin(){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          elevation: 10,
          borderOnForeground:true,
          margin:const EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Congratulations ,You Win! \n '
                    'After $tries Of Tries in $time Minutes ',
                selectionColor: Colors.black,

                style:  TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: Colors.amberAccent[200],


                  ),),

                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          _initializeGame();
                        });
                      },
                      child: const Text("Play Again")

                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
  Widget playGame() {

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          if (_startTimer) countUpTimer!  ,
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _cardImgs.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio:  1,
              ),
              itemBuilder: (context, index) {
                return FlipCard(
                  key: _cardStateKeys[index],
                  onFlip: ()   async {
                   await checkMatchImages(index);
                  },
                  flipOnTouch: _cardImgs[index].flipOnTouch,
                  back: _cardImgs[index].isOpen
                      ? const QuestionMark()
                      : getItem(index),
                  front: _cardImgs[index].isOpen
                      ? getItem(index)
                      : const QuestionMark(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget getItem(int index) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.teal[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Image.asset(_cardImgs[index].path,height: 20,),
    );
  }



  void startGameAfterMilliseconds(int milliseconds) async {
    setState(() {
      isIgnoreClick = true;
    });
    await Future.delayed(Duration(seconds: milliseconds), () {
      flipAllImages();
    });
  }

  flipTwoCards(int previousIndex, int index)  async {
    await Future.delayed(const Duration(milliseconds: 700), () {
          _cardStateKeys[previousIndex].currentState?.toggleCard();
          previousIndex = index;
          _cardStateKeys[previousIndex].currentState?.toggleCard();
        });
        isIgnoreClick = false;
        selectedIndices=[];

  }

  void flipAllImages() {
    for (int i = 0; i < _cardImgs.length; i++) {
      _cardImgs[i].isOpen = false;
      setState(() {});
    }
    titleOfPage = "Start Game";
    setState(() {
      countUpTimer=CountUpTimer(startTimer: true,);
      isIgnoreClick = false;
      _startTimer=true;
    });
  }

  Future<void> checkMatchImages(int index) async {
    if (selectedIndices.isEmpty) {
      selectedIndices.add(index);
    }else{
      int previousIndex = selectedIndices[0];
      if(previousIndex==index){
        setState(() {
          _cardStateKeys[index].currentState?.isFront=false;
          selectedIndices=[];
        });
      }else{
        setState(() {
          isIgnoreClick = true;
        });

        if (_cardImgs[previousIndex].path == _cardImgs[index].path) {
          setState(() {
            matchingImages(previousIndex,index);
          });
          if(matchesFound >= (_cardImgs.length / 2)){
            Future.delayed(const Duration(seconds: 1),(){
              setState(() {
                gameEnding();
              });
            });

          }
          // not matching
        }  else {

          await flipTwoCards(previousIndex,index);
          setState(() {
            tries++;
          });

        }
      }
    }
  }
  // void _showWinDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (_) => AlertDialog(
  //       title: const Text('You Win!'),
  //       content: const Text('Congratulations, you found all matches!'),
  //       actions: [
  //         TextButton(
  //           onPressed: () {
  //             // Navigator.of(context).pop();
  //             setState(() {
  //               _initializeGame();
  //             });
  //           },
  //           child: const Text('Play Again'),
  //         )
  //       ],
  //     ),
  //   );
  // }

  void gameEnding() {
    time=countUpTimer!.counter;
    print('matchesFound$time');
    titleOfPage="The Game Ended";
    _startTimer=false;
    isIgnoreClick=true;
    finish=true;
  }

  void matchingImages(int previousIndex ,int index) {
    _cardImgs[previousIndex].flipOnTouch = false;
    _cardImgs[index].flipOnTouch = false;
    matchesFound++;
    isIgnoreClick = false;
    selectedIndices=[];
    tries++;
  }


}

