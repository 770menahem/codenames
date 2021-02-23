import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newkodenames/Const.dart';
import 'package:newkodenames/obj/GroupPoint.dart';

class GameFLowDB {
  final CollectionReference collGameFlow = FirebaseFirestore.instance
      .collection('codename')
      .doc(GameInfo().roomName)
      .collection('gameflow');

  createGameInfo() async {
    await collGameFlow.doc("info").set({
      'pointsBlue': startPoint[0],
      'pointsRed': startPoint[1],
      'wordToFind': 0,
      'clue': "",
      'playerTurn': 0,
      'isGameOver': false,
      'groupTurn': 0,
      'hasLeft': false,
      'leftToGuessBlue': 0,
      'leftToGuessRed': 0,
    });
  }

  changePointsBlue(val) async {
    await collGameFlow
        .doc("info")
        .update({'pointsBlue': FieldValue.increment(val)});
  }

  changePointsRed(val) async {
    await collGameFlow
        .doc("info")
        .update({'pointsRed': FieldValue.increment(val)});
  }

  changeWordToFind(val) async => await collGameFlow
      .doc("info")
      .update({'wordToFind': FieldValue.increment(val)});

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

  changeLeftToGuessBlue(val) async => await collGameFlow
      .doc("info")
      .update({'leftToGuessBlue': FieldValue.increment(val)});

  changeLeftToGuessRed(val) async => await collGameFlow
      .doc("info")
      .update({'leftToGuessRed': FieldValue.increment(val)});

  Future<List> pointsBlue() async {
    DocumentSnapshot res = await collGameFlow.doc("info").get();
    return await res['pointsBlue'];
  }

  Future<List> pointsRed() async {
    DocumentSnapshot res = await collGameFlow.doc("info").get();
    return await res['pointsRed'];
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

  Future<List> leftToGuessBlue() async {
    DocumentSnapshot res = await collGameFlow.doc("info").get();
    return await res['leftToGuessBlue'];
  }

  Future<List> leftToGuessRed() async {
    DocumentSnapshot res = await collGameFlow.doc("info").get();
    return await res['leftToGuessRed'];
  }

  get all async => await collGameFlow.doc("info").get();

  void snapShotFlow() {
    collGameFlow.doc('info').snapshots().listen((querySnapshot) {
      GameInfo().updete(querySnapshot.data());
    });
  }
}
