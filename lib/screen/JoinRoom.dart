import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newkodenames/Const.dart';
import 'package:newkodenames/Loading.dart';
import 'package:newkodenames/obj/GroupPoint.dart';
import 'package:newkodenames/obj/Room.dart';

class JoinRoom extends StatefulWidget {
  @override
  _JoinRoomState createState() => _JoinRoomState();
}

class _JoinRoomState extends State<JoinRoom> {
  String error = '';
  bool loading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundTheme,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: loading
            ? Loading()
            : SafeArea(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 250.0,
                        ),
                        SizedBox(
                          child: Text(
                            "הכנס שם חדר",
                            style: TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 50.0,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20.0),
                          child: SizedBox(
                            height: 70.0,
                            child: TextFormField(
                              textDirection: TextDirection.rtl,
                              decoration: InputDecoration(
                                labelText: 'שם',
                              ),
                              validator: (val) =>
                                  val.isEmpty ? 'הכנס שם' : null,
                              onChanged: (val) {
                                setState(() {
                                  GameInfo().roomName = val;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40.0,
                          child: btnApp(
                            Text(
                              'הצטרף',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Colors.pink,
                            () async {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  loading = true;
                                });

                                try {
                                  await Room().joinToRoom(GameInfo().roomName);
                                  Navigator.pop(context);
                                  Navigator.pushNamed(context, "/roles");
                                  joinGame();
                                } catch (e) {
                                  print(e);
                                  setState(() {
                                    loading = false;
                                    error = 'חדר לא קיים';
                                  });
                                }
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 70.0,
                          child: Text(error),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
