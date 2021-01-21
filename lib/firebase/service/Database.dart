import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newkodenames/Const.dart';
import 'package:newkodenames/firebase/service/authService.dart';

class DatabadeService {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('codename');

  Future createRoom(String name) async {
    final user = AuthService().user;
    gameRoom.setOnner();
    print(user);

    final snap = await collection.doc(name).get();

    if (!snap.exists) {
      print("name " + name);
      await collection.doc(name).set({
        'onner': user,
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
  }

  Future addCaptain(String room, String group) async {
    final user = AuthService().user;
    print("sada");
    return await collection.doc(room).set({
      group: {'captain': user},
    });
  }

  Future addGesser(String room, String group) async {
    final user = AuthService().user;

    return await collection.doc(room).update({
      group: {
        'gesser': FieldValue.arrayUnion([user])
      }
    });
  }

  Stream<QuerySnapshot> get room => collection.snapshots();
}
