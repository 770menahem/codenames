import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newkodenames/widget/InputClue.dart';
import 'package:provider/provider.dart';

import '../Const.dart';

class MangerButton extends StatelessWidget {
  final Function newGame;
  final Function incrementTurn;
  final Function setNum;

  const MangerButton({
    Key key,
    @required this.newGame,
    @required this.incrementTurn,
    @required this.setNum,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final showmap = context.watch<GroupPoint>().show;

    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        (currUser.role == captain)
            ? Column(
                children: [
                  FlatButton(
                    minWidth: 110.0,
                    color: Colors.amberAccent,
                    child: showmap ? Text("הסתר מפה") : Text("הצג מפה"),
                    onPressed: () {
                      groupPoints.changeShowMap();
                    },
                  ),
                  InputClue(
                    setNum: this.setNum,
                    submit: this.incrementTurn,
                  ),
                ],
              )
            : FlatButton(
                color: Colors.blueGrey,
                onPressed: () {
                  leftToGuess[currUser.group] += groupPoints.wordToFind;
                  this.incrementTurn();
                },
                child: Text('סיים תור'),
              ),
      ],
    );
  }
}
