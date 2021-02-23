import 'package:flutter/cupertino.dart';
import 'package:newkodenames/firebase/service/GameFlowDb.dart';
import 'package:newkodenames/firebase/service/WordDb.dart';
import 'package:newkodenames/obj/words.dart';

import '../Const.dart';
import 'MyUser.dart';
import 'UserObj.dart';

class GameInfo with ChangeNotifier {
  static final GameInfo _gameInfo = GameInfo._instance();
  factory GameInfo() => _gameInfo;
  GameInfo._instance();

  int _pointsBlue = startPoint[0];
  int _pointsRed = startPoint[1];
  int _wordToFind;
  String _clue;
  bool _showMap = true;
  int _playerTurn;
  Roles _role;
  List<WordObj> _words;
  bool _isGameOver;
  int _groupTurn;
  bool _hasLeft;
  int _leftToGuessBlue;
  int _leftToGuessRed;
  UserObj _currUser;
  String _roomName;
  MyUser _thisUser;

  get isGameOver => this._isGameOver;
  get groupTurn => this._groupTurn;
  get hasLeft => this._hasLeft;
  get leftToGuessBlue => this._leftToGuessBlue;
  get leftToGuessRed => this._leftToGuessRed;
  get currUser => this._currUser;
  get roomName => this._roomName;
  get thisUser => this._thisUser;
  get words => this._words;
  get playerTurn => this._playerTurn;
  get show => this._showMap;
  get role => this._role;
  get clue => this._clue;
  get pointsBlue => this._pointsBlue;
  get pointsRed => this._pointsRed;
  get wordToFind => this._wordToFind;

  void reset() async {
    this._wordToFind = 0;
    this._pointsBlue = startPoint[0];
    this._pointsRed = startPoint[1];
    this._showMap = false;
    this._clue = "";
    this._playerTurn = 0;
    this._leftToGuessBlue = 0;
    this._leftToGuessRed = 0;
    this._groupTurn = 0;
    this._isGameOver = false;
    this._hasLeft = false;
    this._currUser = users[0][0];
    this._words = convertToWordObj(await WordDB().getWords());
    GameFLowDB().createGameInfo();
  }

  void join() async {
    var gameFlow = await GameFLowDB().all;
    updete(gameFlow);
  }

  void updete(gameFlow) async {
    this._wordToFind = gameFlow['wordToFind'];
    this._pointsBlue = gameFlow['pointsBlue'];
    this._pointsRed = gameFlow['pointsRed'];
    this._showMap = false;
    this._clue = gameFlow['clue'];
    this._playerTurn = gameFlow['playerTurn'];
    this._leftToGuessBlue = gameFlow['leftToGuessBlue'];
    this._leftToGuessRed = gameFlow['leftToGuessRed'];
    this._groupTurn = gameFlow['groupTurn'];
    this._isGameOver = gameFlow['isGameOver'];
    this._hasLeft = gameFlow['hasLeft'];
    this._currUser = users[this.groupTurn][this.playerTurn];
  }

  void changeShowMap() {
    this._showMap = !this._showMap;
    notifyListeners();
  }

  void hideMap() {
    this._showMap = false;
    notifyListeners();
  }

  set updateWordToFind(int val) {
    this._wordToFind += val;
    GameFLowDB().changeWordToFind(val);
  }

  set setClue(String newClue) {
    this._clue = newClue;
    GameFLowDB().changeClue();
    notifyListeners();
  }

  set setWordToFind(int val) {
    this._wordToFind += val;
    GameFLowDB().changeWordToFind(val);
    notifyListeners();
  }

  set setPointsBlue(val) {
    this._pointsBlue += val;
    GameFLowDB().changePointsBlue(val);
    notifyListeners();
  }

  set setPointsRed(val) {
    this._pointsRed += val;
    GameFLowDB().changePointsRed(val);
    notifyListeners();
  }

  set setPlayerTurn(val) {
    this._playerTurn = val;
    GameFLowDB().changePlayerTurn();
    notifyListeners();
  }

  set setRole(val) => _role = val;

  set isGameOver(bool val) {
    this._isGameOver = val;
    GameFLowDB().changeIsGameOver();
  }

  set groupTurn(int val) {
    this._groupTurn = val;
    GameFLowDB().changeGroupTurn();
  }

  set hasLeft(bool val) {
    this._hasLeft = val;
    GameFLowDB().changeHasLeft();
  }

  set leftToGuessBlue(int val) {
    this._leftToGuessBlue += val;
    GameFLowDB().changeLeftToGuessBlue(val);
  }

  set leftToGuessRed(int val) {
    this._leftToGuessRed += val;
    GameFLowDB().changeLeftToGuessRed(val);
  }

  set setWords(List<WordObj> words) => this._words = words;
  set currUser(UserObj val) => this._currUser = val;
  set roomName(String val) => this._roomName = val;
  set thisUser(MyUser val) => this._thisUser = val;
}
