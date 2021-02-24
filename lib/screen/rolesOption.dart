// למחוק מילים
// let words longer than one
// add words longer than one
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newkodenames/firebase/service/Database.dart';
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
        case Roles.COUNSELOR_BLUE:
          room.removeCounselor("blueGroup");
          break;
        case Roles.COUNSELOR_RED:
          room.removeCounselor("redGroup");
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
      body: StreamBuilder(
          stream: PlayerDB().collectionGame.snapshots(),
          builder: (context, snapshot) {
            var blueCaptain = Room().blueCaptain;
            var redCaptain = Room().redCaptain;
            var redGuesser = Room().redGuesser;
            var blueGuesser = Room().blueGuesser;
            if (snapshot.hasData) {
              var docRoom = snapshot.data.docChanges[0].doc;
              blueCaptain = docRoom['blueGroup']['captain'];
              redCaptain = docRoom['redGroup']['captain'];
              blueGuesser = docRoom['blueGroup']['guesser'];
              redGuesser = docRoom['redGroup']['guesser'];
            }
            return Container(
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
                        blueCaptain.length == 0 ||
                                blueCaptain['id'] == GameInfo().thisUser.uid
                            ? btn("קפטן", 0, Colors.blue, room.setCaptainToBlue)
                            : btn(
                                "קפטן", 0, Colors.blue.withOpacity(0.2), null),
                        redCaptain.length == 0 ||
                                redCaptain['id'] == GameInfo().thisUser.uid
                            ? btn("קפטן", 0, Colors.red, room.setCaptainToRed)
                            : btn("קפטן", 0, Colors.red.withOpacity(0.2), null),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        blueGuesser.length == 0 ||
                                blueGuesser['id'] == GameInfo().thisUser.uid
                            ? btn("מנחש", 1, Colors.blue[600],
                                room.addGuesserToBlue)
                            : btn("מנחש", 1, Colors.blue[600].withOpacity(0.2),
                                null),
                        redGuesser.length == 0 ||
                                redGuesser['id'] == GameInfo().thisUser.uid
                            ? btn("מנחש", 1, Colors.red[600],
                                room.addGuesserToRed)
                            : btn("מנחש", 1, Colors.red[600].withOpacity(0.2),
                                null),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        btn("יועץ", 2, Colors.blue[600],
                            room.addCounselorToBlue),
                        btn("יועץ", 2, Colors.red[600], room.addCounselorToRed),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
