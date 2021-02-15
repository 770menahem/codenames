import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newkodenames/firebase/service/GameFlowDb.dart';
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

  _newGame() {
    setState(() {
      newGame();
    });
  }

  _chooseCard(int wordIndex) {
    if (GameInfo().currUser.role != captain) {
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

    if (word.color == color[2]) {
      GameInfo().isGameOver = true;
      return;
    }

    if (word.color != color[GameInfo().currUser.group]) {
      GameInfo().leftToGuessGrtoup = GameInfo().wordToFind;
    }

    updatePoints(word, points);

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

  SizedBox appBar() {
    return SizedBox(
      height: 80.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // if (GameInfo().thisUser.isOwner)
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

  Widget winWidget(context, String msg, Color color) {
    return Column(
      children: [
        SizedBox(
          height: 250,
        ),
        Container(
          margin: EdgeInsets.all(50),
          color: Colors.white,
          child: SizedBox(
            height: 120,
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
        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    final show = Provider.of<GameInfo>(context).show;
    final isCaptain =
        Provider.of<GameInfo>(context).role.toString().contains("CAPTAIN");

    return StreamBuilder(
        stream: GameFLowDB().collGameFlow.snapshots(),
        builder: (context, snapshot) {
          DocumentSnapshot doc;
          if (snapshot.hasData) doc = snapshot.data.docChanges[0].doc;
          return Container(
            decoration: backgroundTheme,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        appBar(),
                        User(),
                        SizedBox(
                          height: 50,
                          child: GameInfo().playerTurn == 1 &&
                                  !GameInfo().isGameOver
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
                    endGameMsg(doc, context),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget endGameMsg(DocumentSnapshot doc, BuildContext context) {
    return doc != null && doc['isGameOver']
        ? winWidget(
            context,
            "המשחק נגמר קבוצה: ${GameInfo().currUser.group + 1} הפסידה",
            color[GameInfo().currUser.group])
        : (GameInfo().points[0] == 0)
            ? winWidget(context, "הכחולים ניצחו", color[0])
            : (GameInfo().points[1] == 0)
                ? winWidget(context, "האדומים ניצחו", color[1])
                : Text('');
  }
}
