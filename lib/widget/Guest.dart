import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newkodenames/firebase/service/authService.dart';
import 'package:newkodenames/obj/MyUser.dart';

class Guest extends StatelessWidget {
  final Function loading;
  final Function error;
  final AuthService auth;

  const Guest({Key key, this.loading, this.auth, this.error}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () async {
        loading(true);

        dynamic res = await auth.singInAnon();

        if (res == null) {
          error('ההתחברות נכשלה נסה שוב');
          loading(false);
        }
      },
      color: Colors.pink,
      child: Text(
        'היכנס כאורח',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  // clueForm(
  //     BuildContext context, Function setNum, Function submit, int pointLeft) {
  //   GlobalKey<FormState> key = GlobalKey();
  //   TextEditingController clueController = TextEditingController();
  //   TextEditingController numController = TextEditingController();

  //   bool isNumeric(String s) {
  //     if (s == null) {
  //       return false;
  //     }
  //     return double.parse(s, (e) => null) != null;
  //   }

  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.all(Radius.circular(20.0)),
  //         ),
  //         actionsPadding: EdgeInsets.symmetric(horizontal: 98),
  //         content: Form(
  //           key: key,
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               TextFormField(
  //                 textDirection: TextDirection.rtl,
  //                 controller: clueController,
  //                 validator: (value) =>
  //                     value.split(" ").length == 2 && value.isNotEmpty
  //                         ? null
  //                         : "הכנס עד 2 מילים",
  //                 decoration: InputDecoration(
  //                   hintText: "שם",
  //                 ),
  //                 autofocus: true,
  //               ),
  //               TextFormField(
  //                 controller: numController,
  //                 keyboardType: TextInputType.number,
  //                 validator: (value) {
  //                   return (value.isNotEmpty && isNumeric(value))
  //                       ? (int.parse(value) > 0
  //                           ? int.parse(value) <= pointLeft
  //                               ? null
  //                               : "הכנס מספר עד $pointLeft"
  //                           : "הכנס מספר חיובי")
  //                       : "הכנס רק מספרים";
  //                 },
  //                 decoration: InputDecoration(hintText: "הכנס מספר"),
  //               ),
  //             ],
  //           ),
  //         ),
  //         actions: [
  //           FlatButton(
  //             child: Text(
  //               "אישור",
  //               textDirection: TextDirection.rtl,
  //               style: TextStyle(
  //                 color: Colors.blue,
  //               ),
  //             ),
  //             onPressed: () {
  //               if (key.currentState.validate()) {
  //                 setNum(int.parse(numController.text));
  //                 groupPoints.setClue(clueController.text);

  //                 submit();
  //                 Navigator.of(context).pop();
  //               }
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
