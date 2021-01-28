import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newkodenames/firebase/service/authService.dart';
import 'package:newkodenames/obj/GroupPoint.dart';
import 'package:newkodenames/widget/ClueStatus.dart';
import 'package:newkodenames/obj/words.dart';
import 'package:provider/provider.dart';

import '../widget/Board.dart';
import '../widget/CaptainMap.dart';
import '../Const.dart';
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
    _newGame();
  }

  _newGame() {
    print("new game");
    print(AuthService().name);

    setState(() {
      GroupPoint().reset();
      words = WordObj().getWordObj();
      groupTurn = 0;
      isGameOver = false;
      hasLeft = false;
      leftToGuess = [0, 0];
      currUser = users[0][0];
    });
  }

  _chooseCard(WordObj word) {
    if (currUser.role != captain) {
      _checkGameOver(word);
      _handleChoice(word);
    }
  }

  _incrementTurn() {
    if (!isGameOver) {
      GroupPoint points = GroupPoint();
      points.hideMap();

      points.setPlayerTurn = (points.playerTurn + 1);
      if (points.playerTurn == users[groupTurn].length) {
        points.setPlayerTurn = 0;
        groupTurn = (groupTurn + 1) % users.length;
      }
      currUser = users[groupTurn][points.playerTurn];
    }
  }

  _checkGameOver(WordObj word) {
    if (word.color == color[2]) {
      isGameOver = true;

      endGameMsg(
          context,
          _newGame,
          "המשחק נגמר קבוצה: ${currUser.group + 1} הפסידה",
          color[currUser.group]);
    }
  }

  _numToFind(int num) {
    hasLeft = false;

    if (leftToGuess[currUser.group] > 0) {
      num++;
      hasLeft = true;
    }

    GroupPoint().setWordToFind(num);
  }

  _handleChoice(WordObj word) {
    if (word.color != color[currUser.group]) {
      GroupPoint().updateWordToFind(GroupPoint().wordToFind);
    }

    if (word.color == color[0]) {
      GroupPoint().points[0]--;
    } else if (word.color == color[1]) {
      GroupPoint().points[1]--;
    }

    if (!isGameOver) {
      if (GroupPoint().points[0] == 0) {
        endGameMsg(context, _newGame, "you win", color[0]);
      } else if (GroupPoint().points[1] == 0) {
        endGameMsg(context, _newGame, "you win", color[1]);
      }
    }

    if ((word.color != color[currUser.group] || GroupPoint().wordToFind == 1)) {
      _incrementTurn();
      GroupPoint().setClue("");
      GroupPoint().setWordToFind(0);
    } else {
      GroupPoint().setWordToFind(GroupPoint().wordToFind - 1);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "שם קוד",
        ),
        actions: [
          FlatButton(
            color: Colors.blueGrey[700],
            child: Text("משחק חדש"),
            onPressed: _newGame,
          ),
        ],
      ),
      backgroundColor: Colors.brown[200],
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            User(),
            SizedBox(
              height: 32,
              child:
                  currUser.role != captain && !isGameOver ? ClueStatus() : null,
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
                  child: Provider.of<GroupPoint>(context).show &&
                          currUser.role == captain
                      ? CaptainMap(words: words)
                      : null,
                ),
                MangerButton(
                  newGame: this._newGame,
                  incrementTurn: _incrementTurn,
                  setNum: _numToFind,
                  // setClue: _setClue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
