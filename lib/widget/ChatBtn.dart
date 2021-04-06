import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:newkodenames/obj/GroupPoint.dart';
import 'package:provider/provider.dart';

class ChatBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool newMsg = Provider.of<GameInfo>(context).newMsg;

    return FlatButton(
      shape: StadiumBorder(),
      color: Colors.amberAccent,
      minWidth: 1.0,
      child: Stack(
        children: <Widget>[
          Icon(
            Icons.messenger_sharp,
            color: Colors.blue,
          ),
          if (newMsg)
            Positioned(
              top: 0.0,
              right: 0.0,
              child: Icon(
                Icons.brightness_1,
                size: 8.0,
                color: Colors.redAccent,
              ),
            )
        ],
      ),
      onPressed: () {
        GameInfo().newMsg = false;
        Navigator.pushNamed(context, '/chat');
      },
    );
  }
}
