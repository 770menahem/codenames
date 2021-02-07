import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newkodenames/obj/GroupPoint.dart';

class GameFLowDB {
  final CollectionReference collGameFlow = FirebaseFirestore.instance
      .collection('codename')
      .doc(GameInfo().roomName)
      .collection('gameflow');

  createGameInfo() async {
    await collGameFlow.doc("info").set({
      'points': [8, 9],
      'wordToFind': 0,
      'clue': "",
      'playerTurn': 0,
      'isGameOver': false,
      'groupTurn': 0,
      'hasLeft': false,
      'leftToGuess': [0, 0],
    });
  }

  changePoints() async =>
      await collGameFlow.doc("info").update({'points': GameInfo().points});

  changeWordToFind() async => await collGameFlow
      .doc("info")
      .update({'wordToFind': GameInfo().wordToFind});

  changeClue() async =>
      await collGameFlow.doc("info").update({'clue': GameInfo().clue});

  changePlayerTurn() async => await collGameFlow
      .doc("info")
      .update({'playerTurn': GameInfo().playerTurn});

  changeIsGameOver() async => await collGameFlow
      .doc("info")
      .update({'isGameOver': GameInfo().isGameOver});

  changeGroupTurn() async => await collGameFlow
      .doc("info")
      .update({'groupTurn': GameInfo().groupTurn});
  changeHasLeft() async =>
      await collGameFlow.doc("info").update({'hasLeft': GameInfo().hasLeft});
  changeLeftToGuess() async => await collGameFlow
      .doc("info")
      .update({'leftToGuess': GameInfo().leftToGuess});

  Future<List> points() async {
    DocumentSnapshot res = await collGameFlow.doc("info").get();
    return await res['points'];
  }

  Future<int> wordToFind() async {
    DocumentSnapshot res = await collGameFlow.doc("info").get();
    return await res['wordToFind'];
  }

  Future<String> clue() async {
    DocumentSnapshot res = await collGameFlow.doc("info").get();
    return await res['clue'];
  }

  Future<int> playerTurn() async {
    DocumentSnapshot res = await collGameFlow.doc("info").get();
    return await res['playerTurn'].map((num) => num as int).toList();
  }

  Future<bool> isGameOver() async {
    DocumentSnapshot res = await collGameFlow.doc("info").get();
    return await res['isGameOver'];
  }

  Future<int> groupTurn() async {
    DocumentSnapshot res = await collGameFlow.doc("info").get();
    return await res['groupTurn'];
  }

  Future<bool> hasLeft() async {
    DocumentSnapshot res = await collGameFlow.doc("info").get();
    return await res['hasLeft'];
  }

  Future<List> leftToGuess() async {
    DocumentSnapshot res = await collGameFlow.doc("info").get();
    return await res['leftToGuess'];
  }

  get all async => await collGameFlow.doc("info").get();

  void snapShotFlow() {
    collGameFlow.doc('info').snapshots().listen((querySnapshot) {
      GameInfo().updete(querySnapshot.data());
    });
  }
}
