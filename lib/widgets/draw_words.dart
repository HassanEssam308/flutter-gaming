import 'package:flutter/material.dart';

import '../models/word_model.dart';

class DrawWords extends StatefulWidget {
  List<WordModel> words;
   DrawWords({ required this.words,super.key});

  @override
  State<DrawWords> createState() => _DrawWordsState();
}

class _DrawWordsState extends State<DrawWords> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      alignment: Alignment.center,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 3,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.words.length,
        itemBuilder: (context, index) {
          return Center(
            child: Container(
              color: widget.words[index].isMatch ? Colors.lightGreenAccent[200]
                  :Colors.blue[300],
              child: Text(
                widget.words[index].word,
                style: TextStyle(
                  decoration: widget.words[index].isMatch ? TextDecoration.lineThrough
                      :TextDecoration.none,),
              ),
            ),
          );
        },
      ),
    );;
  }
}
