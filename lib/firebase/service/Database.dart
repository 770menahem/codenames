import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newkodenames/firebase/service/authService.dart';
import 'package:newkodenames/obj/MyUser.dart';

class DatabadeService {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('codename');

  Future createRoom(String name) async {
    try {
      final MyUser user = await AuthService().cuurUser;

      print(user);

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
