import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newkodenames/firebase/service/ChatDb.dart';
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
        ChatDb().createChat();
        WordDB().createWords();
        GameFLowDB().createGameInfo();
        await collectionGame.doc(name).set({
          'owner': {
            "id": GameInfo().thisUser.uid,
            "name": GameInfo().thisUser.name,
          },
          'blueGroup': {
            'captain': {},
            'guesser': {},
            'counselors': [],
          },
          'redGroup': {
            'captain': {},
            'guesser': {},
            'counselors': [],
          },
        });

        final room = await collectionGame.doc(name).get();
        return room.exists;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future delCaptain(String room, String group) async {
    try {
      await collectionGame.doc(room).update({'$group.captain': {}});
    } catch (e) {}
  }

  Future delGuesser(String room, String group) async {
    try {
      await collectionGame.doc(room).update({'$group.guesser': {}});
    } catch (e) {}
  }

  Future delCounselor(String room, String group, counselor) async {
    try {
      await collectionGame.doc(room).update({'$group.counselors': counselor});
    } catch (e) {}
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

  Future addCounselor(String room, String group) async {
    MyUser user = GameInfo().thisUser;
    await collectionGame.doc(room).update({
      '$group.counselors': FieldValue.arrayUnion([
        {
          "id": user.uid,
          "name": user.name,
        }
      ])
    });
  }

  Future addGuesser(String room, String group) async {
    MyUser user = GameInfo().thisUser;
    await collectionGame.doc(room).update({
      '$group.guesser': {
        "id": user.uid,
        "name": user.name,
      }
    });
  }

  ownerUid() async {
    DocumentSnapshot doc = await collectionGame.doc(GameInfo().roomName).get();
    return doc['owner']['id'];
  }

  Stream<DocumentSnapshot> get room =>
      collectionGame.doc(GameInfo().roomName).snapshots();
}
