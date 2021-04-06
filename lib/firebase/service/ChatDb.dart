import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
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

  Future addMsgs(String user, String msg, int group) async {
    await collectionChat.doc('chat').update({
      'messages': FieldValue.arrayUnion([
        {'user': user, 'message': msg, 'group': group}
      ])
    });
  }

  void snapShotFlow() {
    collectionChat.doc('chat').snapshots().listen((querySnapshot) {
      GameInfo().newMsg = true;
    });
  }
}
