import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newkodenames/firebase/service/authService.dart';
import 'package:newkodenames/Loading.dart';
import 'package:newkodenames/obj/GroupPoint.dart';
import 'package:newkodenames/widget/Guest.dart';

import '../Const.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    TextFormField emailInput = TextFormField(
      decoration: InputDecoration(labelText: 'מייל'),
      validator: (val) => val.isEmpty ? 'הכנס מייל' : null,
      onChanged: (val) {
        setState(() {
          email = val;
        });
      },
    );

    TextFormField passInput = TextFormField(
      decoration: InputDecoration(labelText: 'סיסמא'),
      validator: (val) => val.length < 6 ? 'הכנס סיסמא מעל 6 תווים' : null,
      obscureText: true,
      onChanged: (val) {
        setState(() {
          password = val;
        });
      },
    );

    void loadingStatus(bool con) {
      setState(() {
        loading = con;
      });
    }

    void errorMsg(String msg) {
      error = msg;
    }

    SizedBox space = SizedBox(height: 20.0);

    return loading
        ? Loading()
        : Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  space,
                  emailInput,
                  space,
                  passInput,
                  space,
                  Text(error),
                  space,
                  btnApp(
                    SizedBox(
                      width: 80.0,
                      child: Center(
                        child: Text(
                          'התחבר',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Colors.pink,
                    () async {
                      if (_formKey.currentState.validate()) {
                        loadingStatus(true);

                        dynamic res = await _auth.signInWithEmailAndPassword(
                            email, password);
                        GameInfo().thisUser = res;
                        if (res == null) {
                          errorMsg('ההתחברות נכשלה נסה שוב');
                          loadingStatus(false);
                        }
                      }
                    },
                  ),
                  Guest(
                    auth: _auth,
                    loading: loadingStatus,
                    error: errorMsg,
                  ),
                  btnApp(
                    Text(
                      'הירשם',
                      style: TextStyle(color: Colors.white),
                    ),
                    Colors.pink,
                    () async {
                      Navigator.pushNamed(context, '/register');
                    },
                  ),
                ],
              ),
            ),
          );
  }
}
