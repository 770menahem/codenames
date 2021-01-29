import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newkodenames/Const.dart';
import 'package:newkodenames/Loading.dart';
import 'package:newkodenames/obj/MyUser.dart';
import 'package:newkodenames/obj/Room.dart';
import 'package:provider/provider.dart';

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
    final user = Provider.of<MyUser>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "צור חדר",
        ),
      ),
      body: loading
          ? Loading()
          : Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    child: Text(
                      "הכנס שם חדר",
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 50.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70.0,
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'שם'),
                      validator: (val) => val.isEmpty ? 'הכנס שם' : null,
                      onChanged: (val) {
                        setState(() {
                          roomName = val;
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
                            await Room().joinToRoom(roomName);
                            Navigator.pushNamed(context, "/roles");
                          } catch (e) {
                            print(e);
                            setState(() {
                              loading = false;
                              error = 'חדר לא קיים';
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
    );
  }
}
