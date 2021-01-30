import 'package:flutter/cupertino.dart';
import 'package:newkodenames/firebase/service/Database.dart';

import '../Const.dart';
import 'MyUser.dart';

class Room extends ChangeNotifier {
  static final Room _roomInctance = Room._inctance();
  factory Room() => _roomInctance;
  Room._inctance();

  Map _room = {
    'onner': '',
    'name': '',
    'blueGroup': {
      'captain': null,
      'gessers': null,
    },
    'redGroup': {
      'captain': null,
      'gessers': null,
    },
  };

  get hasBlueCaptain => this._room['blueGroup']['captain'].length > 1;
  get hasRedCaptain => this._room['redGroup']['captain'].length > 1;
  get room => this._room;

  joinToRoom(String roomName) async {
    dynamic data = await DatabadeService().joinRoom(roomName);
    _room['onner'] = data['onner'];
    _room['blueGroup'] = data['blueGroup'];
    _room['redGroup'] = data['redGroup'];
    _room['name'] = roomName;
    print(data);
    print(_room);
  }

  dynamic setOnner(MyUser user) async {
    try {
      dynamic res = await DatabadeService().createRoom(roomName, user);

      this._room['onner'] = {
        'id': user.uid,
        "name": user.name,
      };
      return res;
    } catch (e) {
      print(e);
    }
  }

  dynamic setCaptainToBlue(MyUser user) async {
    await DatabadeService().addCaptain(roomName, 'blueGroup', user);

    this._room['blueGroup']['captain'] = {
      'id': user.uid,
      "name": user.name,
    };
  }

  dynamic setCaptainToRed(MyUser user) async {
    await DatabadeService().addCaptain(roomName, 'redGroup', user);

    this._room['onner'] = {
      'id': user.uid,
      "name": user.name,
    };
  }

  dynamic addGesserToBlue(user) async {
    await DatabadeService().addGesser(roomName, "blueGroup", user);

    this._room['blueGroup']['gessers'].add({
      'id': user.uid,
      "name": user.name,
    });
  }

  dynamic addGesserToRed(user) async {
    await DatabadeService().addGesser(roomName, "redGroup", user);

    this._room['redGroup']['gessers'].add({
      'id': user.uid,
      "name": user.name,
    });
  }
}
