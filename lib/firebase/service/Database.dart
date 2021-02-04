import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newkodenames/firebase/service/WordDb.dart';

import '../../Const.dart';

class PlayerDB {
  final CollectionReference collectionGame = FirebaseFirestore.instance
      .collection('codename')
      .doc(roomName)
      .collection('game');

  Future joinRoom(String roomName) async {
    final DocumentSnapshot res = await collectionGame.doc(roomName).get();
    if (!res.exists) throw Error();
    return res.data();
  }

  Future createRoom(String name) async {
    try {
      final DocumentSnapshot res = await collectionGame.doc(name).get();
      if (res.exists) return false;
      DocumentReference snap = collectionGame.doc(name);

      if (snap != null) {
        WordDB().createWords(name);
        await collectionGame.doc(name).set({
          'owner': {
            "id": thisUser.uid,
            "name": thisUser.name,
          },
          'blueGroup': {
            'captain': {},
            'guessers': [],
          },
          'redGroup': {
            'captain': {},
            'guessers': [],
          },
        });

        final room = await collectionGame.doc(name).get();
        return room.exists;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future delCaptain(String room, String group) async {
    try {
      await collectionGame.doc(room).update({'$group.captain': {}});
    } catch (e) {
      print(e);
    }
  }

  Future delGuesser(String room, String group, guessers) async {
    try {
      await collectionGame.doc(room).update({'$group.guessers': guessers});
    } catch (e) {
      print(e);
    }
  }

  Future addCaptain(String room, String group) async {
    await collectionGame.doc(room).update({
      '$group.captain': {
        "id": thisUser.uid,
        "name": thisUser.name,
      }
    });
  }

  Future addGuesser(String room, String group) async {
    await collectionGame.doc(room).update({
      '$group.guessers': FieldValue.arrayUnion([
        {
          "id": thisUser.uid,
          "name": thisUser.name,
        }
      ])
    });
  }

  Stream<DocumentSnapshot> get room => collectionGame.doc(roomName).snapshots();
}
