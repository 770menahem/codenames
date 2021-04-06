import 'package:flutter/material.dart';
import 'firebase/service/WordDb.dart';
import 'obj/GroupPoint.dart';
import 'obj/words.dart';

List color = [Colors.blue[400], Colors.red[300], Colors.black];
List<String> img = ["img/capten.jpg", "img/player.jpg", "img/counselors.jpg"];
const String captain = "captain";
const List<int> startPoint = [9, 8];
bool cardLoading = false;
bool newMsg = false;

enum Roles {
  CAPTAIN_BLUE,
  CAPTAIN_RED,
  GUESSER_BLUE,
  GUESSER_RED,
  COUNSELOR_BLUE,
  COUNSELOR_RED,
}

List<String> roleSrt = [
  'קפטן כחול',
  'קפטן אדום',
  'מנחש כחול',
  'מנחש אדום',
  'יועץ כחול',
  'יועץ אדום'
];

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
  await WordDB().addWords(await WordObj().getWords());

  GameInfo().reset();
}

joinGame() async {
  GameInfo().join();
}

SizedBox btnApp(Widget child, Color color, Function onPressed) {
  return SizedBox(
    width: 150.0,
    child: FlatButton(
      shape: StadiumBorder(),
      color: color,
      child: child,
      onPressed: onPressed,
    ),
  );
}
