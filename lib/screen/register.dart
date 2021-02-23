import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newkodenames/Loading.dart';
import 'package:newkodenames/obj/GroupPoint.dart';

import '../Const.dart';
import '../firebase/service/authService.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  String email = '';
  String password = '';
  String name = '';
  String error = '';
  bool loading = false;

  final _formKey = GlobalKey<FormState>();

  register() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        loading = true;
      });

      dynamic res =
          await _auth.registerWithEmailAndPassword(name, email, password);
      GameInfo().thisUser = res;

      if (res == null) {
        setState(() {
          loading = false;
          error = 'ההרשמה נכשלה נסה שוב';
        });
      } else {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundTheme,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: loading
            ? Loading()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                    child: Form(
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
                              validator: (val) =>
                                  val.isEmpty ? 'הכנס שם' : null,
                              onChanged: (val) {
                                setState(() {
                                  name = val;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 70.0,
                            child: TextFormField(
                              decoration: InputDecoration(labelText: 'מייל'),
                              validator: (val) =>
                                  val.isEmpty ? 'הכנס מייל' : null,
                              onChanged: (val) {
                                setState(() {
                                  error = '';
                                  email = val;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 70.0,
                            child: TextFormField(
                              decoration: InputDecoration(labelText: 'סיסמא'),
                              validator: (val) => val.length < 6
                                  ? 'הכנס סיסמא מעל 6 תווים'
                                  : null,
                              obscureText: true,
                              onChanged: (val) {
                                setState(() {
                                  error = '';
                                  password = val;
                                });
                              },
                            ),
                          ),
                          btnWidth(
                            SizedBox(
                              width: 80.0,
                              child: Center(
                                child: Text(
                                  'הירשם',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Colors.pink,
                            register,
                          ),
                          SizedBox(
                            height: 70.0,
                            child: Text(error),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
