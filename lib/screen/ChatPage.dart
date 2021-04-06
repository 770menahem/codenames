import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newkodenames/Const.dart';
import 'package:newkodenames/firebase/service/ChatDb.dart';
import 'package:newkodenames/obj/GroupPoint.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController msg = TextEditingController();

    return Scaffold(
      body: StreamBuilder(
        stream: ChatDb().collectionChat.snapshots(),
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return Text('');
          }

          final msgs = snapshot.data.docChanges[0].doc['messages'];

          return Column(
            children: [
              Container(
                child: Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ListView.builder(
                      itemCount: msgs.length,
                      itemBuilder: (c, i) {
                        return RichText(
                          text: TextSpan(
                            style: TextStyle(color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "${msgs[i]['user']}: ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0)),
                              TextSpan(
                                  text: msgs[i]['message'],
                                  style: TextStyle(fontSize: 16.0)),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150.0,
                    child: TextFormField(
                      controller: msg,
                      textDirection: TextDirection.rtl,
                      validator: (value) =>
                          value.isNotEmpty ? null : "הכנס תוכן",
                      decoration: InputDecoration(
                        hintText: "הודעה",
                      ),
                    ),
                  ),
                  FlatButton(
                    child: Icon(
                      Icons.send,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      if (msg.value.text.length > 0) {
                        ChatDb()
                            .addMsgs(GameInfo().thisUser.name, msg.value.text);
                        msg.clear();
                      }
                    },
                  ),
                  SizedBox(height: 100.0),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
