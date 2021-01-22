import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newkodenames/Const.dart';

class NewRoom extends StatefulWidget {
  @override
  _NewRoomState createState() => _NewRoomState();
}

class _NewRoomState extends State<NewRoom> {
  // final AuthService _auth = AuthService();
  // final DatabadeService db = DatabadeService();

  // String name = '';
  String error = '';
  bool loading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "צור חדר",
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              child: Text(
                "הרשמה",
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

                    print(roomName);
                    dynamic result = await gameRoom.setOnner();

                    if (result == null) {
                      setState(() {
                        loading = false;
                        error = 'היצירה נכשלה נסה שם אחר';
                      });
                    } else {
                      print(result);
                      Navigator.pushNamed(context, "/game");
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
