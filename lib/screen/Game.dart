import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newkodenames/firebase/service/GameFlowDb.dart';
import 'package:newkodenames/firebase/service/WordDb.dart';
import 'package:newkodenames/firebase/service/authService.dart';
import 'package:newkodenames/obj/GroupPoint.dart';
import 'package:newkodenames/widget/ClueStatus.dart';
import 'package:newkodenames/obj/words.dart';
import 'package:provider/provider.dart';

import '../Const.dart';
import '../widget/Board.dart';
import '../widget/CaptainMap.dart';
import '../widget/ManegerBotom.dart';
import '../widget/Points.dart';
import '../widget/User.dart';
import '../obj/UserObj.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  @override
  void initState() {
    super.initState();
    GameFLowDB().snapShotFlow();
  }

  _newGame() async {
    setState(() async {
      await newGame();
    });
  }

  _chooseCard(int wordIndex) {
    if (GameInfo().currUser.role != captain) {
      _checkGameOver(wordIndex);
      _handleChoice(wordIndex);
    }
  }

  _incrementTurn() {
    if (!GameInfo().isGameOver) {
      GameInfo game = GameInfo();
      game.hideMap();

      if (game.playerTurn + 1 == users[game.groupTurn].length) {
        game.setPlayerTurn = 0;
        GameInfo().groupTurn = (game.groupTurn + 1) % users.length;
      } else {
        game.setPlayerTurn = (game.playerTurn + 1);
      }
      GameInfo().currUser = users[game.groupTurn][game.playerTurn];
    }
  }

  _checkGameOver(int wordIndex) {
    if (GameInfo().words[wordIndex].color == color[2]) {
      GameInfo().isGameOver = true;

      endGameMsg(
          context,
          _newGame,
          "המשחק נגמר קבוצה: ${GameInfo().currUser.group + 1} הפסידה",
          color[GameInfo().currUser.group]);
    }
  }

  _numToFind(int num) {
    GameInfo().hasLeft = false;

    if (GameInfo().leftToGuess[GameInfo().groupTurn] > 0) {
      num++;
      GameInfo().hasLeft = true;
    }

    GameInfo().setWordToFind = num;
  }

  _handleChoice(int wordIndex) {
    WordObj word = GameInfo().words[wordIndex];
    List points = GameInfo().points;

    if (word.color != color[GameInfo().currUser.group]) {
      GameInfo().leftToGuessGrtoup = GameInfo().wordToFind;
    }

    updatePoints(word, points);

    winMsg(points);

    if ((word.color != color[GameInfo().currUser.group] ||
        GameInfo().wordToFind == 1)) {
      _incrementTurn();
      GameInfo().setClue = "";
      GameInfo().setWordToFind = 0;
    } else {
      GameInfo().setWordToFind = GameInfo().wordToFind - 1;
    }
  }

  void updatePoints(WordObj word, List points) {
    if (word.color == color[0]) {
      points[0]--;
    } else if (word.color == color[1]) {
      points[1]--;
    }
    GameInfo().setPoints = points;
  }

  void winMsg(List points) {
    if (!GameInfo().isGameOver) {
      GameInfo().isGameOver = false;
      if (points[0] == 0) {
        endGameMsg(context, _newGame, "הכחולים ניצחו", color[0]);
      } else if (points[1] == 0) {
        endGameMsg(context, _newGame, "האדומים ניצחו", color[1]);
      }
    } else {
      endGameMsg(
          context,
          _newGame,
          "המשחק נגמר קבוצה: ${GameInfo().currUser.group + 1} הפסידה",
          color[GameInfo().currUser.group]);
    }
  }

  SizedBox appBar() {
    return SizedBox(
      height: 80.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (GameInfo().thisUser.isOwner)
            FlatButton(
              color: Colors.blueGrey[700],
              child: Text("משחק חדש"),
              onPressed: _newGame,
            ),
          SizedBox(
            width: 1.0,
          ),
          Text(
            '   חדר:${GameInfo().roomName}',
            style: TextStyle(fontSize: 30.0),
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    final show = Provider.of<GameInfo>(context).show;
    final isCaptain =
        Provider.of<GameInfo>(context).role.toString().contains("CAPTAIN");

    return StreamBuilder(
        stream: GameFLowDB().collGameFlow.snapshots(),
        builder: (context, snapshot) {
          return Container(
            decoration: backgroundTheme,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    appBar(),
                    User(),
                    SizedBox(
                      height: 50,
                      child:
                          GameInfo().playerTurn == 1 && !GameInfo().isGameOver
                              ? ClueStatus()
                              : null,
                    ),
                    Board(
                      onChoose: this._chooseCard,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Points(),
                        SizedBox(
                          height: 160,
                          width: 160,
                          child: show && isCaptain ? CaptainMap() : null,
                        ),
                        MangerButton(
                          incrementTurn: _incrementTurn,
                          setNum: _numToFind,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

endGameMsg(BuildContext context, Function newgame, String msg, Color color) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: FlatButton(
          onPressed: () {
            newgame();
          },
          child: Text(
            msg,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            ),
          ),
        ),
        actions: [
          FlatButton(
            child: Text(
              "משחק חדש",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              newgame();
            },
          ),
        ],
      );
    },
  );
}
