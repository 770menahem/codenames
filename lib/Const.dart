import 'package:flutter/material.dart';
import 'obj/UserObj.dart';

List color = [Colors.blue[400], Colors.red[400], Colors.black];
List<String> img = ["img/capten.jpg", "img/player.jpg"];
bool isGameOver;
int playerTurn;
int groupTurn;
// String clue;
bool hasLeft;
List leftToGuess;
List words;
UserObj currUser;
const String captain = "captain";
final GroupPoint groupPoints = GroupPoint();
final Showmap showmap = Showmap();
final WordToFind wordToFind = WordToFind();
final Clue clue = Clue();

class Showmap with ChangeNotifier {
  bool showMap = true;

  void change() {
    this.showMap = !this.showMap;
    notifyListeners();
  }

  get show => this.showMap;
}

class GroupPoint with ChangeNotifier {
  List<int> points = [8, 9];

  void change(int val) {
    this.points[currUser.group] += val;
    notifyListeners();
  }

  get point => this.points;
}

class WordToFind with ChangeNotifier {
  int wordToFind;

  void change(int val) {
    this.wordToFind = val;
    notifyListeners();
  }

  get num => this.wordToFind;
}

class Clue with ChangeNotifier {
  String _clue;

  void change(String newClue) {
    this._clue = newClue;
    notifyListeners();
  }

  get clue => this._clue;
}
