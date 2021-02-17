import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newkodenames/obj/words.dart';

import '../Const.dart';

class AddWord extends StatefulWidget {
  static List<String> wordToAdd = [];

  @override
  _AddWordState createState() => _AddWordState();
}

class _AddWordState extends State<AddWord> {
  final GlobalKey<FormState> clueKey = GlobalKey();
  final List<TextEditingController> controllers = List<TextEditingController>();

  void addToList() {
    AddWord.wordToAdd.clear();
    controllers.forEach(
      (controller) {
        if (controller.text.length > 0) {
          if (!AddWord.wordToAdd.contains(controller.text)) {
            AddWord.wordToAdd.add(controller.text);
            print(controller.text);
          }
        }
      },
    );

    WordObj().initList(AddWord.wordToAdd);
  }

  @override
  Widget build(BuildContext context) {
    controllers.clear();

    for (int i = 0; i < 25; i++) {
      controllers.add(TextEditingController());
      if (AddWord.wordToAdd.length >= i + 1)
        controllers[i].text = AddWord.wordToAdd[i];
    }

    List<FlatButton> actionBtn = [
      FlatButton.icon(
        color: Colors.green,
        icon: Icon(Icons.save),
        onPressed: () {
          addToList();
          Navigator.pop(context);
        },
        label: Text("הוסף"),
      ),
      FlatButton.icon(
        color: Colors.red,
        icon: Icon(Icons.delete_forever),
        onPressed: () {
          WordObj().clearList();
          AddWord.wordToAdd.clear();
          setState(() {
            controllers.clear();
          });
        },
        label: Text("אפס"),
      ),
    ];

    Container gridBoard = Container(
      height: 400,
      margin: EdgeInsets.symmetric(vertical: 12.0),
      padding: EdgeInsets.symmetric(horizontal: 6),
      child: GridView.count(
        scrollDirection: Axis.vertical,
        crossAxisCount: 5,
        children: List.generate(
          this.controllers.length,
          (i) => Container(
            margin: EdgeInsets.all(2),
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.deepOrange[300],
            ),
            child: TextField(
              controller: controllers[i],
              decoration: InputDecoration(
                  labelText: "${i + 1}",
                  labelStyle: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      ),
    );

    return Container(
      decoration: backgroundTheme,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        // appBar: AppBar(
        //   title: Center(
        //     child: Text(
        //       "הוסף מילים",
        //       textDirection: TextDirection.rtl,
        //     ),
        //   ),
        //   actions: actionBtn,
        // ),
        body: Column(
          children: [
            SizedBox(
              height: 40.0,
            ),
            gridBoard,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FlatButton.icon(
                  color: Colors.green,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  icon: Icon(Icons.save),
                  onPressed: () {
                    addToList();
                    Navigator.pop(context);
                  },
                  label: Text("הוסף"),
                ),
                FlatButton.icon(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  color: Colors.red,
                  icon: Icon(Icons.delete_forever),
                  onPressed: () {
                    WordObj().clearList();
                    AddWord.wordToAdd.clear();
                    setState(() {
                      controllers.clear();
                    });
                  },
                  label: Text("אפס"),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "הכנס מילים כרצונך.\n" +
                  "הסדר לא משנה הם יתערבבו לפני המשחק,\n" +
                  "משבצות שישארו ריקות ימולאו במילים אחרות!",
              style: TextStyle(
                fontSize: 30.0,
              ),
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
      ),
    );
  }
}
