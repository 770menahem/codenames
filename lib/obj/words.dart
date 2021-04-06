import 'package:flutter/material.dart';
import 'package:newkodenames/firebase/service/WordListDB.dart';

class WordObj {
  int id;
  String word;
  bool choose;
  Color color;
  static List<WordObj> gameWords = List();
  static List<WordObj> userWord = List();
  static List allWords;

  WordObj({
    this.id,
    this.word,
    this.color,
    this.choose = false,
  });

  clearList() {
    userWord.clear();
  }

  initList(List list) {
    userWord.clear();

    list.forEach((element) {
      userWord.add(WordObj(word: element));
    });
  }

  Future<List> getWords() async {
    List<Color> colors = [
      Colors.blue[400],
      Colors.red[300],
      Colors.black,
      Colors.white70
    ];

    if (allWords == null) {
      allWords = await WordListDB().getWords();
    }

    gameWords.clear();

    userWord.forEach((e) => e.choose = false);

    gameWords.addAll(userWord);
    allWords.shuffle();

    initGameWord(allWords, colors);

    return gameWords;
  }

  void initGameWord(List allWords, List<Color> colors) {
    int i = 0;

    while (gameWords.length < 25) {
      if (gameWords.length == 0 || !gameWords.contains(allWords[i])) {
        gameWords.add(WordObj(
          word: allWords[i],
        ));
      }

      i = i + 1 % allWords.length;
    }

    for (i = 0; i < gameWords.length; i++) {
      gameWords[i].color = colors[3];
    }

    for (i = 0; i < 9; i++) {
      gameWords[i].color = colors[0];
    }

    for (i = i; i < 17; i++) {
      gameWords[i].color = colors[1];
    }

    gameWords[i].color = colors[2];

    gameWords.shuffle();

    gameWords.asMap().forEach((i, element) {
      element.id = i;
    });
  }

  @override
  bool operator ==(other) {
    return (other is WordObj) && other.word == this.word;
  }

  @override
  int get hashCode => super.hashCode;
}
