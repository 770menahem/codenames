import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newkodenames/obj/words.dart';

class MyCard extends StatefulWidget {
  final WordObj word;
  final Function onChoose;

  const MyCard({
    Key key,
    @required this.word,
    @required this.onChoose,
  }) : super(key: key);

  @override
  _MyCardState createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  checkIfChoose() {
    if (!widget.word.choose) {
      print(widget.word.word);
      this.widget.onChoose(widget.word);

      setState(() {
        widget.word.choose = !widget.word.choose;
      });
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
            color: this.widget.word.choose
                ? this.widget.word.color
                : Colors.yellow[100],
          ),
          child: Center(
            child: Text(
              widget.word.word,
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
