import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newkodenames/obj/GroupPoint.dart';
import 'package:newkodenames/obj/words.dart';

class WordDB {
  final CollectionReference collectionWords = FirebaseFirestore.instance
      .collection('codename')
      .doc(GameInfo().roomName)
      .collection('words');

  createWords() async {
    DocumentReference words = collectionWords.doc('words');
    if (words != null) {
      await words.set({
        'words': [],
      });
    } else {
      throw Exception("can't create wordDB");
    }
  }

  Future addWords(List<WordObj> words) async {
    List wordsDB = [];

    words.forEach((word) {
      wordsDB.add({
        "id": word.id,
        "word": word.word,
        "choose": word.choose,
        "color": word.color.value,
      });
    });

    await collectionWords.doc('words').update({'words': wordsDB});
  }

  Future choosing(WordObj word) async {
    await collectionWords.doc('words').update({
      'words': FieldValue.arrayRemove([
        {
          "id": word.id,
          "word": word.word,
          "choose": word.choose,
          "color": word.color.value,
        }
      ])
    });
    await collectionWords.doc('words').update({
      'words': FieldValue.arrayUnion([
        {
          "id": word.id,
          "word": word.word,
          "choose": true,
          "color": word.color.value,
        }
      ])
    });
  }

  get words => collectionWords.doc('words');

  getWords() async {
    DocumentSnapshot words = await collectionWords.doc('words').get();
    return words.data()['words'];
  }
}
