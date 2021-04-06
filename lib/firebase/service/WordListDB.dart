import 'package:cloud_firestore/cloud_firestore.dart';

class WordListDB {
  final CollectionReference wordsDoc =
      FirebaseFirestore.instance.collection('wordList');

  getWords() async {
    final DocumentSnapshot doc = await wordsDoc.doc('words').get();
    return doc.data()['words'];
  }
}
