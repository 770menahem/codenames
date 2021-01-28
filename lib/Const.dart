import 'package:flutter/material.dart';
import 'obj/GroupPoint.dart';
import 'obj/Room.dart';
import 'obj/UserObj.dart';

List color = [Colors.blue[400], Colors.red[400], Colors.black];
List<String> img = ["img/capten.jpg", "img/player.jpg"];
bool isGameOver;
int groupTurn;
bool hasLeft;
List leftToGuess;
List words;
UserObj currUser;
String roomName;
const String captain = "captain";
