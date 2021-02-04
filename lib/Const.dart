import 'package:flutter/material.dart';
import 'package:newkodenames/obj/MyUser.dart';
import 'obj/UserObj.dart';
import 'obj/words.dart';

List color = [Colors.blue[400], Colors.red[400], Colors.black];
List<String> img = ["img/capten.jpg", "img/player.jpg"];
// bool isGameOver;
// int groupTurn;
// bool hasLeft;
// List leftToGuess;
// UserObj currUser;
// String roomName;
// MyUser thisUser;
const String captain = "captain";

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
      Colors.red[500],
      Colors.purple[300],
      Colors.blue[500],
    ],
  ),
);

List<WordObj> convertToWordObj(List word) {
  List<WordObj> wordList = [];

  word.forEach((word) {
    String valueString =
        word['color'].split('(0x')[1].split(')')[0]; // kind of hacky..
    int value = int.parse(valueString, radix: 16);

    wordList.add(WordObj(
      id: word['id'],
      color: Color(value),
      choose: word['choose'] == true,
      word: word['word'],
    ));
  });

  wordList.sort((c, n) => c.id.compareTo(n.id));
  return wordList;
}
