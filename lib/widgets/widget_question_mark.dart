import 'package:flutter/material.dart';
class QuestionMark extends StatelessWidget {
  const QuestionMark({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.teal[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Image.asset('assets/images/animals/quest.png',height: 20,),
    );
  }
}



