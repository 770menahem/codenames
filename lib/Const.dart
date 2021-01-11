import 'package:flutter/material.dart';
import 'obj/UserObj.dart';

List color = [
  Colors.blue[400],
  Colors.red[400],
  Colors.black,
];
List<String> img = ["img/capten.jpg", "img/player.jpg"];
bool isGameOver;
List<int> groupPoint = [8, 9];
int playerTurn;
int groupTurn;
bool showMap;
int numToFind;
String clue;
bool hasLeft;
List leftToGuess;
List words;
UserObj currUser;
const String captain = "captain";

class GameInfo {
  bool isGameOver;
  List<int> groupPoint = [8, 9];
  int playerTurn;
  int groupTurn;
  bool showMap;
  int numToFind;
  String clue;
  bool hasLeft;
  List leftToGuess;
  List words;
  UserObj currUser;

  bool get mapShow {
    return showMap;
  }
}
