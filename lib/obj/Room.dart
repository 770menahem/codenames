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
      'guesser': {},
      'counselors': [],
    },
    'redGroup': {
      'captain': {},
      'guesser': {},
      'counselors': [],
    },
  };

  get blueCaptain => this._room['blueGroup']['captain'];
  get owner => this._room['owner']['id'];

  get redCaptain => this._room['redGroup']['captain'];
  get redGuesser => this._room['redGroup']['guesser'];
  get blueGuesser => this._room['blueGroup']['guesser'];

  get room => this._room;

  joinToRoom(String roomName) async {
    dynamic data = await PlayerDB().joinRoom(roomName);
    _room['owner'] = data['owner'];
    _room['blueGroup'] = data['blueGroup'];
    _room['redGroup'] = data['redGroup'];
    _room['name'] = roomName;
  }

  void removeCaptain(String group) {
    this._room[group]['captain'] = {};
    PlayerDB().delCaptain(_room['name'], group);
  }

  void removeGuesser(String group) {
    _room[group]['guesser'] = {};
    PlayerDB().delGuesser(_room['name'], group);
  }

  void removeCounselor(String group) {
    _room[group]['counselors']
        .removeWhere((counselor) => GameInfo().thisUser.uid == counselor['id']);

    PlayerDB().delCounselor(_room['name'], group, _room[group]['counselors']);
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
          'guesser': {},
          'counselors': [],
        },
        'redGroup': {
          'captain': {},
          'guesser': {},
          'counselors': [],
        },
      };

      return res;
    } catch (e) {}
  }

  dynamic setCaptainToBlue() async {
    GameInfo().thisUser.giveRole(Roles.CAPTAIN_BLUE);
    await PlayerDB().addCaptain(GameInfo().roomName, 'blueGroup');

    this._room['blueGroup']['captain'] = {
      'id': GameInfo().thisUser.uid,
      "name": GameInfo().thisUser.name,
    };

    GameInfo().setRole = Roles.CAPTAIN_BLUE;
  }

  dynamic setCaptainToRed() async {
    GameInfo().thisUser.giveRole(Roles.CAPTAIN_RED);
    await PlayerDB().addCaptain(GameInfo().roomName, 'redGroup');

    this._room['redGroup']['captain'] = {
      'id': GameInfo().thisUser.uid,
      "name": GameInfo().thisUser.name,
    };
    GameInfo().setRole = Roles.CAPTAIN_RED;
  }

  dynamic addGuesserToBlue() async {
    GameInfo().thisUser.giveRole(Roles.GUESSER_BLUE);
    await PlayerDB().addGuesser(GameInfo().roomName, "blueGroup");

    this._room['blueGroup']['guesser'] = {
      'id': GameInfo().thisUser.uid,
      "name": GameInfo().thisUser.name,
    };

    GameInfo().setRole = Roles.GUESSER_BLUE;
  }

  dynamic addGuesserToRed() async {
    GameInfo().thisUser.giveRole(Roles.GUESSER_RED);
    await PlayerDB().addGuesser(GameInfo().roomName, "redGroup");

    this._room['redGroup']['guesser'] = {
      'id': GameInfo().thisUser.uid,
      "name": GameInfo().thisUser.name,
    };

    GameInfo().setRole = Roles.GUESSER_RED;
  }

  dynamic addCounselorToBlue() async {
    GameInfo().thisUser.giveRole(Roles.COUNSELOR_BLUE);
    await PlayerDB().addCounselor(GameInfo().roomName, "blueGroup");

    this._room['blueGroup']['counselors'].add({
      'id': GameInfo().thisUser.uid,
      "name": GameInfo().thisUser.name,
    });

    GameInfo().setRole = Roles.COUNSELOR_BLUE;
  }

  dynamic addCounselorToRed() async {
    GameInfo().thisUser.giveRole(Roles.COUNSELOR_RED);
    await PlayerDB().addCounselor(GameInfo().roomName, "redGroup");

    this._room['redGroup']['counselors'].add({
      'id': GameInfo().thisUser.uid,
      "name": GameInfo().thisUser.name,
    });

    GameInfo().setRole = Roles.COUNSELOR_RED;
  }
}
