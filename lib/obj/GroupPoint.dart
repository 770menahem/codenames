import 'package:flutter/cupertino.dart';
import 'package:newkodenames/firebase/service/WordDb.dart';
import 'package:newkodenames/obj/words.dart';

import '../Const.dart';
import 'MyUser.dart';
import 'UserObj.dart';

class GameInfo with ChangeNotifier {
  static final GameInfo _gameInfo = GameInfo._instance();
  factory GameInfo() => _gameInfo;
  GameInfo._instance();

  List<int> _points = [8, 9];
  int _wordToFind;
  String _clue;
  bool _showMap = true;
  int _playerTurn;
  Roles _role;
  List<WordObj> _words;
  bool _isGameOver;
  int _groupTurn;
  bool _hasLeft;
  List _leftToGuess;
  UserObj _currUser;
  String _roomName;
  MyUser _thisUser;

  get isGameOver => this._isGameOver;
  get groupTurn => this._groupTurn;
  get hasLeft => this._hasLeft;
  get leftToGuess => this._leftToGuess;
  get currUser => this._currUser;
  get roomName => this._roomName;
  get thisUser => this._thisUser;
  get words => this._words;
  get playerTurn => this._playerTurn;
  get show => this._showMap;
  get role => this._role;
  get clue => this._clue;
  get points => this._points;
  get wordToFind => this._wordToFind;

  void reset() async {
    this._wordToFind = 0;
    this._points = [9, 8];
    this._showMap = false;
    this._clue = "";
    this._playerTurn = 0;
    this._leftToGuess = [0, 0];
    this._groupTurn = 0;
    this._isGameOver = false;
    this._hasLeft = false;
    this._currUser = users[0][0];
    this._words = convertToWordObj(await WordDB().gatWords());
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

  set setWords(List<WordObj> words) => this._words = words;
  set chooseWord(int index) => this._words[index].choose = true;
  set setRole(val) => _role = val;

  set isGameOver(bool val) => this._isGameOver = val;
  set groupTurn(int val) => this._groupTurn = val;
  set hasLeft(bool val) => this._hasLeft = val;
  set leftToGuess(List val) => this._leftToGuess = val;
  set leftToGuessGrtoup(int val) =>
      this._leftToGuess[this._currUser.group] = val;
  set currUser(UserObj val) => this._currUser = val;
  set roomName(String val) => this._roomName = val;
  set thisUser(MyUser val) => this._thisUser = val;
}
