import 'package:flutter/material.dart';
import 'package:flutter_gaming/models/letters_model.dart';
import 'package:flutter_gaming/models/word_model.dart';
import 'package:flutter_gaming/widgets/count_up_timer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../widgets/draw_words.dart';
import '../words_repository.dart';

class WordPuzzleGame extends StatefulWidget {
  const WordPuzzleGame({super.key});

  @override
  State<WordPuzzleGame> createState() => _WordPuzzleGameState();
}

class _WordPuzzleGameState extends State<WordPuzzleGame> {
  List<WordModel> _words = [];
  List<LetterWithClickedModel> _lettersWithClicked = [];
  late WordsRepository _wordsRepository;

  CountUpTimer? _countUpTimer = null;

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  Future<void> _initializeGame() async {
    _wordsRepository = WordsRepository(context: context);
    _words = await _wordsRepository.getWords();
    _lettersWithClicked = await _wordsRepository.getLetters();
    _countUpTimer = _wordsRepository.startTimer();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[300],
      child:_words.isEmpty?
      const SpinKitDualRing(
        color: Colors.white,
        size: 50.0,
      ): Column(
        children: [
          if (_countUpTimer != null) _countUpTimer!,
          drawLetters(_lettersWithClicked),
          DrawWords(
            words: _words,
          ),
        ],
      ),
    );
  }



  Widget drawLetters(List<LetterWithClickedModel> letters) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 9,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: letters.length,
        itemBuilder: (context, index) {
          return IgnorePointer(
            ignoring: letters[index].isMatch ? true : false,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: letters[index].isMatch
                    ? Colors.lightGreenAccent[200]
                    : letters[index].isClicked
                        ? Colors.red[200]
                        : Colors.blue[200],
              ),
              child: TextButton(
                onPressed: () {
                  _wordsRepository.checkLetter(index,
                      letters[index].character, _lettersWithClicked, _words);
                  if (_wordsRepository.score == _words.length) {
                    _showWinDialog();
                  }
                  setState(() {});
                },
                style: TextButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.zero))),
                child: Text(
                  letters[index].character,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }


  void _showWinDialog() {
    _countUpTimer?.countUpTimerState.stopTimer() ;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('You Win!'),
        content:  Text('Congratulations, you found all matches After ${_countUpTimer?.counter}  !'),
        actions: [
          TextButton(
            onPressed: () {
              restartGame();
              Navigator.of(context).pop();
              setState(() {});
            },
            child: const Text('Play Again'),
          )
        ],
      ),
    );

  }

  void restartGame() {
    _wordsRepository.score=0;
    for (LetterWithClickedModel letter in _lettersWithClicked) {
      letter.isClicked = false;
      letter.isMatch = false;
    }
    for (WordModel  word in _words) {
      word.isMatch=false;
    }
    _countUpTimer?.countUpTimerState.restartTimer();
  }

}
