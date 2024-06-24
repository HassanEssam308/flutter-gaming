

class LetterWithClickedModel {
  String character;
  bool isClicked ;
  bool isMatch ;
  LetterWithClickedModel({  this.character="",this.isClicked =false ,this.isMatch =false});

  List<LetterWithClickedModel> newModel(List<String> letters){
    List<LetterWithClickedModel> newModelOfLetters=[];
    for(String letter in letters){
      newModelOfLetters.add(LetterWithClickedModel(character: letter, isClicked:false, isMatch: false));
    }
    return newModelOfLetters ;
  }
}
