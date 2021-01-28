import 'package:newkodenames/firebase/service/Database.dart';

import '../Const.dart';
import 'MyUser.dart';

class Room {
  static final Room _roomInctance = Room._inctance();
  factory Room() => _roomInctance;
  Room._inctance();

  Map _room = {
    'onner': '',
    'name': '',
    'blueGroup': {
      'captain': '',
      'gessers': [],
    },
    'redGroup': {
      'captain': '',
      'gessers': [],
    },
  };

  get room => this._room;

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
