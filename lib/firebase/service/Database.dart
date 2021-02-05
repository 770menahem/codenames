import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newkodenames/firebase/service/GameFlowDb.dart';
import 'package:newkodenames/firebase/service/WordDb.dart';
import 'package:newkodenames/obj/GroupPoint.dart';
import 'package:newkodenames/obj/MyUser.dart';

class PlayerDB {
  final CollectionReference collectionGame = FirebaseFirestore.instance
      .collection('codename')
      .doc(GameInfo().roomName)
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
        WordDB().createWords();
        GameFLowDB().createGameInfo();
        await collectionGame.doc(name).set({
          'owner': {
            "id": GameInfo().thisUser.uid,
            "name": GameInfo().thisUser.name,
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
    MyUser user = GameInfo().thisUser;
    await collectionGame.doc(room).update({
      '$group.captain': {
        "id": user.uid,
        "name": user.name,
      }
    });
  }

  Future addGuesser(String room, String group) async {
    MyUser user = GameInfo().thisUser;
    await collectionGame.doc(room).update({
      '$group.guessers': FieldValue.arrayUnion([
        {
          "id": user.uid,
          "name": user.name,
        }
      ])
    });
  }

  Stream<DocumentSnapshot> get room =>
      collectionGame.doc(GameInfo().roomName).snapshots();
}
