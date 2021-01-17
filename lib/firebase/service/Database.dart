import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newkodenames/obj/MyUser.dart';

class DatabadeService {
  final String uid;
  DatabadeService(this.uid);

  final CollectionReference collection =
      FirebaseFirestore.instance.collection('codename');

  Future createRoom(MyUser user, String name) async {
    return await collection.doc(name).set({
      'onner': user.name,
      'blueGroup': {
        'captain': '',
        'gessers': [],
      },
      'redGroup': {
        'captain': '',
        'gessers': [],
      },
    });
  }

  Future addCaptain(MyUser user, String room, String group) async {
    return await collection.doc(room).set({
      group: {
        'captain': {
          'uid': user.uid,
          'name': user.name,
        }
      },
    });
  }

  Future addGesser(MyUser user, String room, String group) async {
    var roo = await collection.doc(room).snapshots().toList();

    return await collection.doc(room).update({
      'gesser': [
        {
          'uid': user.uid,
          'name': user.name,
        }
      ]
    });
  }

  Stream<QuerySnapshot> get room => collection.snapshots();
}
