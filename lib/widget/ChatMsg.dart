import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatMsg extends StatelessWidget {
  final Color msgColor;
  final String user;
  final String msg;

  const ChatMsg({
    Key key,
    @required this.msgColor,
    @required this.user,
    @required this.msg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      margin: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: msgColor,
      ),
      child: RichText(
        text: TextSpan(
          style: TextStyle(color: Colors.black),
          children: <TextSpan>[
            TextSpan(
                text: "$user: ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0)),
            TextSpan(text: msg, style: TextStyle(fontSize: 16.0)),
          ],
        ),
      ),
    );
  }
}
