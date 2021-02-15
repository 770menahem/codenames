import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newkodenames/obj/GroupPoint.dart';
import 'package:newkodenames/obj/Room.dart';
import '../Const.dart';

class RoleOption extends StatefulWidget {
  @override
  _RoleOptionState createState() => _RoleOptionState();
}

class _RoleOptionState extends State<RoleOption> {
  final Room room = Room();
  @override
  void initState() {
    if (GameInfo().role != null) {
      clearRole();
    }
    super.initState();
  }

  void clearRole() {
    Roles role = GameInfo().role;
    print("role = " + role.toString());

    if (role != null) {
      switch (role) {
        case Roles.CAPTAIN_BLUE:
          room.removeCaptain("blueGroup");
          break;
        case Roles.CAPTAIN_RED:
          room.removeCaptain("redGroup");
          break;
        case Roles.GUESSER_BLUE:
          room.removeGuesser("blueGroup");
          break;
        case Roles.GUESSER_RED:
          room.removeGuesser("redGroup");
          break;
        default:
      }

      role = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Container btn(String txt, int imgIndex, Color color, Function setRole) {
      return Container(
        width: 150.0,
        margin: EdgeInsets.all(10.0),
        child: FlatButton(
          height: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(img[imgIndex]),
              ),
              Text(txt),
            ],
          ),
          color: color,
          onPressed: () async {
            if (setRole != null) {
              try {
                await setRole();

                Navigator.pushNamed(context, '/game')
                    .then((value) => clearRole());
              } catch (e) {
                print(e);
              }
            }
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
      );
    }

    final Shader linearGradient = LinearGradient(
      colors: <Color>[Colors.red[800], Colors.blue[800]],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 350.0, 70.0));

    return Scaffold(
      body: Container(
        decoration: backgroundTheme,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "בחר תפקיד",
                style: TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()..shader = linearGradient,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  room.blueCaptain.length == 0
                      ? btn("קפטן", 0, Colors.blue, room.setCaptainToBlue)
                      : btn("קפטן", 0, Colors.blue.withOpacity(0.2), null),
                  room.redCaptain.length == 0
                      ? btn("קפטן", 0, Colors.red, room.setCaptainToRed)
                      : btn("קפטן", 0, Colors.red.withOpacity(0.2), null),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  btn("מנחש", 1, Colors.blue[600], room.addGuesserToBlue),
                  btn("מנחש", 1, Colors.red[600], room.addGuesserToRed),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
