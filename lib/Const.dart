import 'package:flutter/material.dart';
import 'firebase/service/WordDb.dart';
import 'firebase/service/authService.dart';
import 'obj/GroupPoint.dart';
import 'obj/words.dart';

List color = [Colors.blue[400], Colors.red[400], Colors.black];
List<String> img = ["img/capten.jpg", "img/player.jpg"];
const String captain = "captain";
const List<int> startPoint = [9, 8];
enum Roles {
  CAPTAIN_BLUE,
  CAPTAIN_RED,
  GUESSER_RED,
  GUESSER_BLUE,
}

final BoxDecoration backgroundTheme = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.blue[500],
      Colors.purple[300],
      Colors.red[500],
    ],
  ),
);

List<WordObj> convertToWordObj(List word) {
  List<WordObj> wordList = [];

  word.forEach((word) {
    wordList.add(WordObj(
      id: word['id'],
      color: Color(word['color']),
      choose: word['choose'] == true,
      word: word['word'],
    ));
  });

  wordList.sort((c, n) => c.id.compareTo(n.id));
  return wordList;
}

newGame() async {
  print("new game");
  print(AuthService().name);

  await WordDB().addWords(WordObj().getWords());

  GameInfo().reset();
}

joinGame() async {
  print("join game");
  print(AuthService().name);

  GameInfo().join();
}

SizedBox btnWidth(Widget child, Color color, Function onPressed) {
  return SizedBox(
    width: 150.0,
    child: Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: RaisedButton(
        child: child,
        color: color,
        onPressed: onPressed,
      ),
    ),
  );
}
