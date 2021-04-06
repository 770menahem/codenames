import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newkodenames/Const.dart';
import 'package:newkodenames/obj/GroupPoint.dart';

class ChatDb {
  final CollectionReference collectionChat = FirebaseFirestore.instance
      .collection('codename')
      .doc(GameInfo().roomName)
      .collection('chat');

  createChat() async {
    DocumentReference chat = collectionChat.doc('chat');
    if (chat != null) {
      await chat.set({
        'messages': [],
      });
    } else {
      throw Exception("can't create chatDB");
    }
  }

  Future addMsgs(String user, String msg) async {
    await collectionChat.doc('chat').update({
      'messages': FieldValue.arrayUnion([
        {'user': user, 'message': msg}
      ])
    });
  }

  void snapShotFlow() {
    collectionChat.doc('chat').snapshots().listen((querySnapshot) {
      GameInfo().newMsg = true;
      print('d');
    });
  }
}
