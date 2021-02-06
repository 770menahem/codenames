import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newkodenames/Const.dart';
import 'package:newkodenames/Loading.dart';
import 'package:newkodenames/obj/GroupPoint.dart';
import 'package:newkodenames/obj/Room.dart';

class NewRoom extends StatefulWidget {
  @override
  _NewRoomState createState() => _NewRoomState();
}

class _NewRoomState extends State<NewRoom> {
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
            : SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 300.0,
                        ),
                        SizedBox(
                          child: Text(
                            "צור חדר",
                            style: TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 50.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 70.0,
                          child: TextFormField(
                            textDirection: TextDirection.rtl,
                            decoration: InputDecoration(labelText: 'שם'),
                            validator: (val) => val.isEmpty ? 'הכנס שם' : null,
                            onChanged: (val) {
                              setState(() {
                                GameInfo().roomName = val;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 40.0,
                          child: RaisedButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  loading = true;
                                });

                                try {
                                  if (await Room().setOwner()) {
                                    Navigator.pop(context);
                                    Navigator.pushNamed(context, "/roles");
                                    newGame();
                                  } else {
                                    setState(() {
                                      loading = false;
                                      error = 'היצירה נכשלה נסה שם אחר';
                                    });
                                  }
                                } catch (e) {
                                  setState(() {
                                    loading = false;
                                    error = 'היצירה נכשלה נסה שם אחר';
                                  });
                                }
                              }
                            },
                            color: Colors.pink,
                            child: SizedBox(
                              width: 80.0,
                              child: Center(
                                child: Text(
                                  'צור',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
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
