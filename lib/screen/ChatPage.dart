import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newkodenames/firebase/service/ChatDb.dart';
import 'package:newkodenames/obj/GroupPoint.dart';
import 'package:newkodenames/widget/ChatMsg.dart';

import '../Const.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController msg = TextEditingController();
    int group = GameInfo().thisUser.role.toString().contains('BLUE') ? 0 : 1;
    Color msgColor = color[group];

    return Container(
      decoration: backgroundTheme,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: StreamBuilder(
          stream: ChatDb().collectionChat.snapshots(),
          builder: (_, snapshot) {
            if (!snapshot.hasData) {
              return Text('');
            }

            final msgs =
                snapshot.data.docChanges[0].doc['messages'].reversed.toList();
            return Stack(
              children: [
                ListView.builder(
                  padding: EdgeInsets.only(top: 35),
                  itemCount: msgs.length,
                  itemBuilder: (c, i) {
                    return ChatMsg(
                      msg: msgs[i]['message'],
                      user: msgs[i]['user'],
                      msgColor: msgs[i]['group'] != null
                          ? color[msgs[i]['group']]
                          : msgColor,
                    );
                  },
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.all(10.0),
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: msg,
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            decoration: InputDecoration(
                                hintText: "...הכנס הודעה",
                                // hint dir
                                hintStyle: TextStyle(color: Colors.black54),
                                border: InputBorder.none),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        FlatButton(
                          child: Icon(
                            Icons.send,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            if (msg.value.text.length > 0) {
                              ChatDb().addMsgs(GameInfo().thisUser.name,
                                  msg.value.text, group);
                              msg.clear();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
