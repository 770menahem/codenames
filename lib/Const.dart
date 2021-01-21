import 'package:flutter/material.dart';
import 'package:newkodenames/firebase/service/authService.dart';
import 'package:newkodenames/obj/MyUser.dart';
import 'package:provider/provider.dart';
import 'obj/UserObj.dart';

List color = [Colors.blue[400], Colors.red[400], Colors.black];
List<String> img = ["img/capten.jpg", "img/player.jpg"];
bool isGameOver;
int groupTurn;
bool hasLeft;
List leftToGuess;
List words;
UserObj currUser;
const String captain = "captain";
final GroupPoint groupPoints = GroupPoint();
final gameRoom = Room();

class Room {
  Map _room = {
    'onner': '',
    'blueGroup': {
      'captain': '',
      'gessers': [],
    },
    'redGroup': {
      'captain': '',
      'gessers': [],
    },
  };

  get room => this._room;

  void setOnner() => this._room['onner'] = AuthService().user;

  void setCaptainToBlue() =>
      this._room['blueGroup']['captain'] = AuthService().user;

  void setCaptainToRed() => this._room['onner'] = AuthService().user;

  void addGesserToBlue() =>
      this._room['blueGroup']['gessers'].add(AuthService().user);

  void addGesserToRed() =>
      this._room['redGroup']['gessers'].add(AuthService().user);
}

class GroupPoint with ChangeNotifier {
  List<int> _points = [8, 9];
  int _wordToFind;
  String _clue;
  bool _showMap = true;
  int _playerTurn;

  get playerTurn => this._playerTurn;
  get show => this._showMap;
  get clue => this._clue;
  get points => this._points;
  get wordToFind => this._wordToFind;

  void reset() {
    this._wordToFind = 0;
    this._points = [9, 8];
    this._showMap = false;
    this._clue = "";
    this._playerTurn = 0;
  }

  void changeShowMap() {
    this._showMap = !this._showMap;
    notifyListeners();
  }

  void hideMap() {
    this._showMap = false;
    notifyListeners();
  }

  void updateWordToFind(int val) {
    this._wordToFind += val;
    // notifyListeners();
  }

  void setClue(String newClue) {
    this._clue = newClue;
    notifyListeners();
  }

  void setWordToFind(int val) {
    this._wordToFind = val;
    notifyListeners();
  }

  set setPoints(val) {
    this._points = val;
    notifyListeners();
  }

  set setPlayerTurn(val) {
    this._playerTurn = val;
    notifyListeners();
  }
}
