import 'package:flutter/cupertino.dart';
import 'package:newkodenames/firebase/service/Database.dart';
import 'package:newkodenames/obj/GroupPoint.dart';

import '../Const.dart';

class Room extends ChangeNotifier {
  static final Room _roomInstance = Room._instance();

  factory Room() => _roomInstance;

  Room._instance();

  Map _room = {
    'owner': '',
    'name': '',
    'blueGroup': {
      'captain': {},
      'guessers': [],
    },
    'redGroup': {
      'captain': {},
      'guessers': [],
    },
  };

  get blueCaptain => this._room['blueGroup']['captain'];

  get redCaptain => this._room['redGroup']['captain'];

  get room => this._room;

  joinToRoom(String roomName) async {
    dynamic data = await PlayerDB().joinRoom(roomName);
    _room['owner'] = data['owner'];
    _room['blueGroup'] = data['blueGroup'];
    _room['redGroup'] = data['redGroup'];
    _room['name'] = roomName;
    print(data);
    print(_room);
  }

  void removeCaptain(String group) {
    this._room[group]['captain'] = {};
    PlayerDB().delCaptain(_room['name'], group);
  }

  void removeGuesser(String group) {
    _room[group]['guessers']
        .removeWhere((guesser) => GameInfo().thisUser.uid == guesser['id']);

    PlayerDB().delGuesser(_room['name'], group, _room[group]['guessers']);
  }

  dynamic setOwner() async {
    try {
      GameInfo().thisUser.makeOnner();
      dynamic res = await PlayerDB().createRoom(GameInfo().roomName);

      GameInfo().setRole = null;

      this._room = {
        'owner': {
          'id': GameInfo().thisUser.uid,
          "name": GameInfo().thisUser.name,
        },
        'name': GameInfo().roomName,
        'blueGroup': {
          'captain': {},
          'guessers': [],
        },
        'redGroup': {
          'captain': {},
          'guessers': [],
        },
      };

      return res;
    } catch (e) {
      print(e);
    }
  }

  dynamic setCaptainToBlue() async {
    await PlayerDB().addCaptain(GameInfo().roomName, 'blueGroup');

    this._room['blueGroup'] = {
      'captain': {
        'id': GameInfo().thisUser.uid,
        "name": GameInfo().thisUser.name,
      },
      'guessers': [...this._room['blueGroup']['guessers']],
    };

    GameInfo().setRole = Roles.CAPTAIN_BLUE;
  }

  dynamic setCaptainToRed() async {
    await PlayerDB().addCaptain(GameInfo().roomName, 'redGroup');

    this._room['redGroup'] = {
      'captain': {
        'id': GameInfo().thisUser.uid,
        "name": GameInfo().thisUser.name,
      },
      'guessers': [...this._room['redGroup']['guessers']],
    };
    GameInfo().setRole = Roles.CAPTAIN_RED;
  }

  dynamic addGuesserToBlue() async {
    await PlayerDB().addGuesser(GameInfo().roomName, "blueGroup");

    this._room['blueGroup']['guessers'].add({
      'id': GameInfo().thisUser.uid,
      "name": GameInfo().thisUser.name,
    });

    GameInfo().setRole = Roles.GUESSER_BLUE;
  }

  dynamic addGuesserToRed() async {
    await PlayerDB().addGuesser(GameInfo().roomName, "redGroup");

    this._room['redGroup']['guessers'].add({
      'id': GameInfo().thisUser.uid,
      "name": GameInfo().thisUser.name,
    });

    GameInfo().setRole = Roles.GUESSER_RED;
  }
}
