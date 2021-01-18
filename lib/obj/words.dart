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
  String word;
  bool choose;
  Color color;
  static List<WordObj> gameWord = List();

  WordObj({
    this.word,
    this.color,
    this.choose = false,
  });

  clearList() {
    gameWord = List<WordObj>();
  }

  initList(List list) {
    gameWord.clear();

    list.forEach((element) {
      gameWord.add(WordObj(word: element));
    });
  }

  List getWordObj() {
    List<Color> colors = [
      Colors.blue[400],
      Colors.red[400],
      Colors.black,
      Colors.white70
    ];

    List allWords = Words().getList();

    allWords.shuffle();

    int i = 0;

    while (gameWord.length < 25) {
      if (gameWord.length == 0 || !gameWord.contains(allWords[i])) {
        gameWord.add(WordObj(
          word: allWords[i],
        ));
      }

      i = i + 1 % allWords.length;
    }

    for (i = 0; i < gameWord.length; i++) {
      gameWord[i].color = colors[3];
    }

    for (i = 0; i < 9; i++) {
      gameWord[i].color = colors[0];
    }

    for (i = i; i < 17; i++) {
      gameWord[i].color = colors[1];
    }

    gameWord[i].color = colors[2];

    gameWord.shuffle();

    return gameWord;
  }

  @override
  bool operator ==(other) {
    return (other is WordObj) && other.word == this.word;
  }

  @override
  int get hashCode => super.hashCode;
}
