// import 'package:flutter/cupertino.dart';

// import 'Card.dart';

// class Board extends StatefulWidget {
//   final Function onChoose;

//   Board({
//     @required this.onChoose,
//   });

//   @override
//   _BoardState createState() => _BoardState();
// }

// class _BoardState extends State<Board> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 390,
//       width: 390,
//       child: GridView.count(
//         scrollDirection: Axis.horizontal,
//         crossAxisCount: 5,
//         shrinkWrap: false,
//         children: List.generate(
//           25,
//           (index) => MyCard(
//             wordIndex: index,
//             onChoose: widget.onChoose,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:newkodenames/Loading.dart';
import 'package:newkodenames/firebase/service/WordDb.dart';
import 'package:newkodenames/obj/GroupPoint.dart';

import 'Card.dart';
import '../Const.dart';

class Board extends StatefulWidget {
  final Function onChoose;

  Board({
    @required this.onChoose,
  });

  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 390,
      width: 390,
      child: StreamBuilder(
          stream: WordDB().words.snapshots(),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data['words'].length == 25) {
                GameInfo().setWords = convertToWordObj(snapshot.data['words']);
              }

              return GridView.count(
                scrollDirection: Axis.horizontal,
                crossAxisCount: 5,
                shrinkWrap: false,
                children: List.generate(
                  25,
                  (index) => MyCard(
                    wordIndex: index,
                    onChoose: this.widget.onChoose,
                  ),
                ),
              );
            }

            return Loading();
          }),
    );
  }
}
