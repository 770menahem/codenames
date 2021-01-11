import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newkodenames/obj/words.dart';

class MyCard extends StatelessWidget {
  final WordObj word;
  final Function onChoose;

  const MyCard({
    Key key,
    @required this.word,
    @required this.onChoose,
  }) : super(key: key);

  checkIfChoose() {
    if (!word.choose) {
      print(word.word);
      this.onChoose(word);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        checkIfChoose();
      },
      child: Center(
        child: Container(
          width: 100,
          height: 50,
          margin: EdgeInsets.symmetric(horizontal: 2),
          padding: EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: this.word.choose ? this.word.color : Colors.yellow[100],
          ),
          child: Center(
            child: Text(
              word.word,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
