import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newkodenames/firebase/service/ChatDb.dart';
import 'package:newkodenames/obj/Room.dart';
import 'package:provider/provider.dart';

import 'package:newkodenames/firebase/service/GameFlowDb.dart';
import 'package:newkodenames/obj/GroupPoint.dart';
import 'package:newkodenames/widget/ClueStatus.dart';
import 'package:vibration/vibration.dart';
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
  Timer timer;
  Roles roleChecked;

  @override
  void initState() {
    super.initState();
    GameFLowDB().snapShotFlow();

    timer = Timer.periodic(Duration(milliseconds: 500), (Timer t) {
      vibrate();
    });
  }

  void vibrate() async {
    if (roleChecked != GameInfo().currUser.role) {
      if (GameInfo().currUser.role == GameInfo().thisUser.role) {
        if (await Vibration.hasVibrator()) {
          Vibration.vibrate();
        }
      }

      roleChecked = GameInfo().currUser.role;
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  _newGame() {
    setState(() {
      newGame();
    });
  }

  _chooseCard(int wordIndex) {
    if (GameInfo().currUser.role != captain && !GameInfo().isGameOver) {
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

    final group = GameInfo().groupTurn == 0
        ? GameInfo().leftToGuessBlue
        : GameInfo().leftToGuessRed;

    if (group > 0) {
      num++;
      GameInfo().hasLeft = true;
    }

    GameInfo().setWordToFind = num;
  }

  _handleChoice(int wordIndex) async {
    Color endGame = color[2];
    Color wordColor = GameInfo().words[wordIndex].color;

    if (wordColor == endGame) {
      GameInfo().isGameOver = true;
      return;
    }

    if (wordColor != color[GameInfo().currUser.group]) {
      GameInfo().groupTurn == 0
          ? GameInfo().leftToGuessBlue = GameInfo().wordToFind
          : GameInfo().leftToGuessRed = GameInfo().wordToFind;
    }

    updatePoints(wordColor);

    if ((wordColor != color[GameInfo().currUser.group] ||
        GameInfo().wordToFind <= 1)) {
      _incrementTurn();
      GameInfo().setClue = "";
      GameInfo().setWordToFind = -GameInfo().wordToFind;
    } else {
      GameInfo().setWordToFind = -1;
    }
  }

  void updatePoints(Color wordColor) {
    if (wordColor == color[0]) {
      GameInfo().setPointsBlue = -1;
    } else if (wordColor == color[1]) {
      GameInfo().setPointsRed = -1;
    }
  }

  SizedBox appBar() {
    return SizedBox(
      height: 80.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (GameInfo().thisUser.uid == Room().owner)
            FlatButton(
              shape: StadiumBorder(),
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

  Widget endGameWidget(context, String msg, Color color) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
        ),
        Center(
          child: Container(
            padding: EdgeInsets.all(100),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.8),
                  spreadRadius: 10,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: SizedBox(
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
          if (snapshot.hasData) {
            doc = snapshot.data.docChanges[0].doc;
          }

          return Container(
            decoration: backgroundTheme,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SafeArea(
                child: SingleChildScrollView(
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
            ),
          );
        });
  }

  Widget chat() {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: MaterialButton(
        onPressed: () => {},
        child: Text('REGISTER LOGIN'),
      ),
    );
  }

  Widget endGameMsg(DocumentSnapshot doc, BuildContext context) {
    String groupmsg = GameInfo().currUser.group == 0 ? "הכחולה" : "האדומה";
    if (doc != null && doc['isGameOver']) {
      return endGameWidget(context, "המשחק נגמר הקבוצה $groupmsg הפסידה",
          color[GameInfo().currUser.group]);
    } else if ((GameInfo().pointsBlue == 0)) {
      return endGameWidget(context, "הכחולים ניצחו", color[0]);
    } else if ((GameInfo().pointsRed == 0)) {
      return endGameWidget(context, "האדומים ניצחו", color[1]);
    }

    return Text('');
  }
}
