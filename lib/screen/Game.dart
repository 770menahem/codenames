import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newkodenames/firebase/service/Database.dart';
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
    _newGame();
  }

  _newGame() async {
    print("new game");
    print(AuthService().name);

    await WordDB().addWords(WordObj().getWordObj());

    setState(() {
      GameInfo().reset();
      groupTurn = 0;
      isGameOver = false;
      hasLeft = false;
      leftToGuess = [0, 0];
      currUser = users[0][0];
    });
  }

  _chooseCard(int wordIndex) {
    if (currUser.role != captain) {
      _checkGameOver(wordIndex);
      _handleChoice(wordIndex);
    }
  }

  _incrementTurn() {
    if (!isGameOver) {
      GameInfo points = GameInfo();
      points.hideMap();

      points.setPlayerTurn = (points.playerTurn + 1);
      if (points.playerTurn == users[groupTurn].length) {
        points.setPlayerTurn = 0;
        groupTurn = (groupTurn + 1) % users.length;
      }
      currUser = users[groupTurn][points.playerTurn];
    }
  }

  _checkGameOver(int wordIndex) {
    if (GameInfo().words[wordIndex].color == color[2]) {
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

    GameInfo().setWordToFind(num);
  }

  _handleChoice(int wordIndex) {
    WordObj word = GameInfo().words[wordIndex];
    List points = GameInfo().points;

    if (word.color != color[currUser.group]) {
      GameInfo().updateWordToFind(GameInfo().wordToFind);
    }

    if (word.color == color[0]) {
      points[0]--;
    } else if (word.color == color[1]) {
      points[1]--;
    }

    if (!isGameOver) {
      if (points[0] == 0) {
        endGameMsg(context, _newGame, "you win", color[0]);
      } else if (points[1] == 0) {
        endGameMsg(context, _newGame, "you win", color[1]);
      }
    }

    if ((word.color != color[currUser.group] || GameInfo().wordToFind == 1)) {
      _incrementTurn();
      GameInfo().setClue("");
      GameInfo().setWordToFind(0);
    } else {
      GameInfo().setWordToFind(GameInfo().wordToFind - 1);
    }
  }

  Widget build(BuildContext context) {
    final show = Provider.of<GameInfo>(context).show;
    final captainRole =
        Provider.of<GameInfo>(context).role.toString().contains("CAPTAIN");

    return Container(
      decoration: backgroundTheme,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            roomName,
          ),
          actions: [
            FlatButton(
              color: Colors.blueGrey[700],
              child: Text("משחק חדש"),
              onPressed: _newGame,
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              User(),
              SizedBox(
                height: 32,
                child: currUser.role != captain && !isGameOver
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
                    child: show && captainRole ? CaptainMap() : null,
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
