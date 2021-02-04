import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newkodenames/obj/GroupPoint.dart';
import 'package:newkodenames/widget/InputClue.dart';
import 'package:provider/provider.dart';

import '../Const.dart';

class MangerButton extends StatelessWidget {
  final Function incrementTurn;
  final Function setNum;

  const MangerButton({
    Key key,
    @required this.incrementTurn,
    @required this.setNum,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final showmap = context.watch<GameInfo>().show;
    final role = context.watch<GameInfo>().role;

    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        (role.toString().contains("CAPTAIN") && currUser.role == captain)
            ? Column(
                children: [
                  FlatButton(
                    minWidth: 110.0,
                    color: Colors.amberAccent,
                    child: showmap ? Text("הסתר מפה") : Text("הצג מפה"),
                    onPressed: () {
                      GameInfo().changeShowMap();
                    },
                  ),
                  InputClue(
                    setNum: this.setNum,
                    submit: this.incrementTurn,
                  ),
                ],
              )
            : (!role.toString().contains("CAPTAIN") && currUser.role != captain)
                ? FlatButton(
                    color: Colors.blueGrey,
                    onPressed: () {
                      leftToGuess[currUser.group] += GameInfo().wordToFind;
                      this.incrementTurn();
                    },
                    child: Text('סיים תור'),
                  )
                : Text(""),
      ],
    );
  }
}
