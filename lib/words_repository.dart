import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_gaming/screens/word_puzzle_game.dart';
import 'package:flutter_gaming/widgets/count_up_timer.dart';
import 'models/letters_model.dart';
import 'models/word_model.dart';
import 'package:http/http.dart' as http;

class WordsRepository {

  List<int> _selectedIndexesOfLetters = [];
  String _theWord = "";
  int score = 0;
  BuildContext context;
  CountUpTimer? _countUpTimer ;

  WordsRepository({required this.context});

  Future<List<WordModel>> getWords() async {
    final response = await http.get(
        Uri.parse('https://mocki.io/v1/92bff7d3-8ce3-43d9-b219-3ef090b09664'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<WordModel> words = [];
      for (String word in data) {
        words.add(WordModel(word: word, isMatch: false));
      }
      return words;
    } else {
      return [];
    }
  }

  Future<List<LetterWithClickedModel>> getLetters() async {
    final response = await http.get(
        Uri.parse('https://mocki.io/v1/f6557703-eaf9-4264-9dbd-99e932166148'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)["letters"];
      List<LetterWithClickedModel> lettersWithClicked =
          LetterWithClickedModel().newModel(List.from(data));
      return lettersWithClicked;
    } else {
      return [];
    }
  }

  checkLetter(int index, String letter,
      List<LetterWithClickedModel> lettersWithClicked, List<WordModel> words) {
    if (_selectedIndexesOfLetters.isEmpty) {
      _selectedIndexesOfLetters.add(index);
      lettersWithClicked[index].isClicked = true;
      _theWord += letter;
    } else {
      if (_selectedIndexesOfLetters.contains(index)) {
        _selectedIndexesOfLetters.remove(index);
        lettersWithClicked[index].isClicked = false;
        _theWord = "";
        for (int index in _selectedIndexesOfLetters) {
          _theWord += lettersWithClicked[index].character;
        }
      } else {
        // print(" list=$_selectedIndexesOfLetters _theWord=$_theWord");
            int previousIndex =
                _selectedIndexesOfLetters[_selectedIndexesOfLetters.length - 1];
            // print("previousIndex =$previousIndex || $_selectedIndexesOfLetters");
            if (index == previousIndex + 1 || index == previousIndex + 9) {
              _selectedIndexesOfLetters.add(index);
              lettersWithClicked[index].isClicked = true;
              _theWord += letter;
               _checkMatchWord(_theWord, words, lettersWithClicked);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                content: Text("the letters must be vertical or horizontal"),
              ),
              );
            }

      }
    }
  }

  void _checkMatchWord(
    String theWord,
    List<WordModel> words,
    List<LetterWithClickedModel> lettersWithClicked,
  ) {
    for (WordModel word in words) {
      if (word.word == theWord) {
        word.isMatch = true;
        for (int index in _selectedIndexesOfLetters) {
          lettersWithClicked[index].isMatch = true;
        }
        score++;
        _selectedIndexesOfLetters = [];
        _theWord = "";
      }
    }
  }
CountUpTimer startTimer (){
 _countUpTimer=CountUpTimer(startTimer: true,);
    return _countUpTimer!;
  }

}
