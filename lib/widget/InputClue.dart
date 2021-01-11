import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../Const.dart';

class InputClue extends StatelessWidget {
  final Function setNum;
  final Function setClue;
  final Function submit;
  final int pointLeft;

  const InputClue({
    Key key,
    @required this.setNum,
    @required this.setClue,
    @required this.submit,
    @required this.pointLeft,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.amberAccent,
      child: Text("רמז"),
      onPressed: () {
        clueForm(context, setNum, setClue, submit, pointLeft);
      },
    );
  }
}

clueForm(BuildContext context, Function setNum, Function setClue,
    Function submit, int pointLeft) {
  GlobalKey<FormState> key = GlobalKey();
  TextEditingController clueController = TextEditingController();
  TextEditingController numController = TextEditingController();

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        actionsPadding: EdgeInsets.symmetric(horizontal: 98),
        content: Form(
          key: key,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                textDirection: TextDirection.rtl,
                controller: clueController,
                validator: (value) =>
                   value.split(" ").length == 1 && value.isNotEmpty
                      ? null
                      : "הכנס מילה אחת"
                ,
                decoration: InputDecoration(
                  hintText: "הכנס רמז",
                ),
                autofocus: true,
              ),
              TextFormField(
                controller: numController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  return (value.isNotEmpty && isNumeric(value))
                      ? (int.parse(value) > 0
                          ? int.parse(value) <= pointLeft
                              ? null
                              : "הכנס מספר עד $pointLeft"
                          : "הכנס מספר חיובי")
                      : "הכנס רק מספרים";
                },
                decoration: InputDecoration(hintText: "הכנס מספר"),
              ),
            ],
          ),
        ),
        actions: [
          FlatButton(
            child: Text(
              "אישור",
              textDirection: TextDirection.rtl,
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
            onPressed: () {
              if (key.currentState.validate()) {
                setNum(int.parse(numController.text));
                setClue(clueController.text);
                print(clue);
                submit();
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      );
    },
  );
}
