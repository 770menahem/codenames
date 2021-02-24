import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newkodenames/Loading.dart';
import 'package:newkodenames/obj/GroupPoint.dart';
import 'package:newkodenames/obj/words.dart';
import 'package:provider/provider.dart';

class MyCard extends StatefulWidget {
  final int wordIndex;
  final Function onChoose;

  const MyCard({
    Key key,
    @required this.wordIndex,
    @required this.onChoose,
  }) : super(key: key);

  @override
  _MyCardState createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  bool loading = false;

  checkIfChoose(WordObj word) async {
    if (GameInfo().role == GameInfo().currUser.role &&
        GameInfo().currUser.role.toString().contains("G") &&
        !word.choose) {
      setState(() => loading = true);

      await this.widget.onChoose(this.widget.wordIndex);

      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    WordObj wordObj = Provider.of<GameInfo>(context).words[widget.wordIndex];
    String word = wordObj.word;
    bool choose = wordObj.choose;
    Color color = wordObj.color;

    return loading || word == null
        ? Loading()
        : GestureDetector(
            onTap: () async => await checkIfChoose(wordObj),
            child: Center(
              child: Container(
                width: 100,
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 2),
                padding: EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: choose ? color : Colors.yellow[100],
                ),
                child: Center(
                  child: Text(
                    word,
                    textAlign: TextAlign.center,
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
