import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newkodenames/obj/GroupPoint.dart';
import 'package:newkodenames/obj/Room.dart';
import 'package:newkodenames/widget/ChatBtn.dart';
import 'package:newkodenames/widget/InputClue.dart';
import 'package:provider/provider.dart';

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
        if (GameInfo().thisUser.uid == Room().owner)
          FlatButton(
            shape: StadiumBorder(),
            color: Colors.amberAccent,
            child: Text("צור/הסר מילים"),
            onPressed: () {
              Navigator.pushNamed(context, "/addWord");
            },
          ),
        role.toString().contains("CAPTAIN")
            ? FlatButton(
                minWidth: 110.0,
                color: Colors.amberAccent,
                shape: StadiumBorder(),
                child: showmap ? Text("הסתר מפה") : Text("הצג מפה"),
                onPressed: () {
                  GameInfo().changeShowMap();
                },
              )
            : Text(''),
        (role.toString().contains("CAPTAIN") &&
                GameInfo().role == GameInfo().currUser.role)
            ? InputClue(
                setNum: this.setNum,
                submit: this.incrementTurn,
              )
            : (!role.toString().contains("CAPTAIN") &&
                    GameInfo().role == GameInfo().currUser.role)
                ? FlatButton(
                    shape: StadiumBorder(),
                    color: Colors.blueGrey,
                    onPressed: () {
                      GameInfo().currUser.group == 0
                          ? GameInfo().leftToGuessBlue += GameInfo().wordToFind
                          : GameInfo().leftToGuessRed += GameInfo().wordToFind;
                      this.incrementTurn();
                    },
                    child: Text('סיים תור'),
                  )
                : Text(""),
        ChatBtn(),
      ],
    );
  }
}
