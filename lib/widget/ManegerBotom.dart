import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newkodenames/widget/InputClue.dart';
import 'package:provider/provider.dart';

import '../Const.dart';

class MangerButton extends StatelessWidget {
  final Function newGame;
  final Function handleShowMap;
  final Function incrementTurn;
  final Function setNum;
  final Function setClue;
  final int pointLeft;

  const MangerButton({
    Key key,
    @required this.newGame,
    @required this.handleShowMap,
    @required this.incrementTurn,
    @required this.setNum,
    @required this.setClue,
    @required this.pointLeft,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        (currUser.role == captain)
            ? Column(
                children: [
                  FlatButton(
                    color: Colors.amberAccent,
                    child: showMap ? Text("הסתר מפה") : Text("הצג מפה"),
                    onPressed: () {
                      this.handleShowMap();
                    },
                  ),
                  InputClue(
                    setNum: this.setNum,
                    setClue: setClue,
                    submit: this.incrementTurn,
                    pointLeft: pointLeft,
                  ),
                ],
              )
            : FlatButton(
                color: Colors.blueGrey,
                onPressed: () {
                  leftToGuess[currUser.group] += numToFind;
                  this.incrementTurn();
                },
                child: Text('סיים תור'),
              ),
      ],
    );
  }
}
