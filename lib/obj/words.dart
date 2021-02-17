import 'package:flutter/material.dart';

class Words {
  List words = [
    "תרץ",
    "וויניקי אל",
    "מפקד",
    "רשצ",
    "מגמה",
    "תיכנות",
    "קורס",
    "רמת גן",
    "פתח תקוה",
    "סקסופון",
    "סיכה",
    "תיקשוב",
    "מודיעין",
    "חיל האויר",
    "תגית",
    "מסדר",
    "סקירה",
    "טכנולוגיה",
    "תשמ\"ש",
    "שקם",
    "חמשוש",
    "זיכוי",
    "חוגר",
    "קורונה",
    "יד לבנים",
    "אייל קורא",
    "פרוקסי",
    "וויל",
    "יום ספורט",
    "חינוכית",
    "מיקצועית",
    "מסיכה",
    "חנוכה",
    "דף יומי",
    "חדר אוכל",
    "פקקים",
    "אפריקה",
    "אירופה",
    "בורסה",
    "פס",
    "חנתר",
    "ג'אבה",
    "אטמבלר",
    "קוד",
    "בנין",
    "סייבר",
    "מכונה",
    "מ\"ל",
    "למ\"א",
    "ל\"ע",
    "סוף יום",
    "נוהל",
    "החרגה",
    "שבוע",
    "נעול",
    "מחט",
    "גולם",
    "קש",
    "שלג",
    "כפתור",
    "מחלה",
    "עמוד",
    "רב",
    "פירמידה",
    "לב",
    "מסך",
    "מושב",
    "טבליה",
    "מרגל",
    "כוכב",
    "גוש",
    "פה",
    "מתג",
    "עדשה",
    "שלט",
    "גבול",
    "אביב",
    "שוק",
    "מכסה",
    "רשת",
    "ירוק",
    "נסיכה",
    "חומה",
    "סוכן",
    "מיטה",
    "דוקטור",
    "לפיד",
  ];

  List getList() {
    return words;
  }
}

class WordObj {
  int id;
  String word;
  bool choose;
  Color color;
  static List<WordObj> gameWords = List();
  static List<WordObj> userWord = List();

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

  List getWords() {
    List<Color> colors = [
      Colors.blue[400],
      Colors.red[400],
      Colors.black,
      Colors.white70
    ];

    List allWords = Words().getList();
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
