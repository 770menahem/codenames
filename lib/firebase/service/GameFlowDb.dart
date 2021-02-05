import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newkodenames/obj/GroupPoint.dart';

class GameFLowDB {
  final DocumentReference collectionGame = FirebaseFirestore.instance
      .collection('codename')
      .doc(GameInfo().roomName)
      .collection('gameflow')
      .doc("info");

  createGameInfo() async {
    await collectionGame.set({
      'points': GameInfo().points,
      'wordToFind': GameInfo().wordToFind,
      'clue': GameInfo().clue,
      'playerTurn': GameInfo().playerTurn,
      'isGameOver': GameInfo().isGameOver,
      'groupTurn': GameInfo().groupTurn,
      'hasLeft': GameInfo().hasLeft,
      'leftToGuess': GameInfo().leftToGuess,
    });
  }

  changePoints() => collectionGame.set({'points': GameInfo().points});

  changeWordToFind() =>
      collectionGame.set({'wordToFind': GameInfo().wordToFind});

  changeClue() => collectionGame.set({'clue': GameInfo().clue});

  changePlayerTurn() =>
      collectionGame.set({'playerTurn': GameInfo().playerTurn});

  changeIsGameOver() =>
      collectionGame.set({'isGameOver': GameInfo().isGameOver});

  changeGroupTurn() => collectionGame.set({'groupTurn': GameInfo().groupTurn});
  changeHasLeft() => collectionGame.set({'hasLeft': GameInfo().hasLeft});
  changeLeftToGuess() =>
      collectionGame.set({'leftToGuess': GameInfo().leftToGuess});

  getPoint() async {
    DocumentSnapshot res = await collectionGame.get();
    return res['points'];
  }
}
