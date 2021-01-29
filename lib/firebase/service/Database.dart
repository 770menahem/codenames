import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newkodenames/obj/MyUser.dart';

class DatabadeService {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('codename');

  Future joinRoom(String roomName) async {
    final DocumentSnapshot res = await collection.doc(roomName).get();
    if (!res.exists) throw Error();
    return res.data();
  }

  Future createRoom(String name, MyUser user) async {
    try {
      print(user);
      final DocumentSnapshot res = await collection.doc(name).get();
      if (res.exists) return false;
      DocumentReference snap = collection.doc(name);

      if (snap != null) {
        await collection.doc(name).set({
          'onner': {
            "id": user.uid,
            "name": user.name,
          },
          'blueGroup': {
            'captain': '',
            'gessers': [],
          },
          'redGroup': {
            'captain': '',
            'gessers': [],
          },
        });

        final room = await collection.doc(name).get();
        return room.exists;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future addCaptain(String room, String group, MyUser user) async {
    await collection.doc(room).update({
      '$group.captain': {
        "id": user.uid,
        "name": user.name,
      }
    });
  }

  Future addGesser(String room, String group, MyUser user) async {
    await collection.doc(room).update({
      '$group.gessers': FieldValue.arrayUnion([
        {
          "id": user.uid,
          "name": user.name,
        }
      ])
    });
  }

  Stream<QuerySnapshot> get room => collection.snapshots();
}
