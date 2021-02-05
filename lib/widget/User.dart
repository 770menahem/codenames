import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newkodenames/obj/GroupPoint.dart';
import 'package:newkodenames/obj/MyUser.dart';
import 'package:provider/provider.dart';
import '../Const.dart';

class User extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userName = Provider.of<MyUser>(context).name;
    final playerTurn = Provider.of<GameInfo>(context).playerTurn;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: color[GameInfo().groupTurn],
          ),
          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(img[int.parse(playerTurn)]),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "$userName",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "${GameInfo().currUser.group + 1} :קבוצה",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
