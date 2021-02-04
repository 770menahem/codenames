import 'package:flutter/cupertino.dart';
import 'package:newkodenames/obj/GroupPoint.dart';
import 'package:provider/provider.dart';

import '../Const.dart';

class ClueStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final numToFind = Provider.of<GameInfo>(context).wordToFind;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          "רמז: ${GameInfo().clue}",
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color[GameInfo().groupTurn],
          ),
        ),
        Text(
          (GameInfo().hasLeft && numToFind > 1)
              ? "מספר: ${numToFind - 1} + 1"
              : "מספר: $numToFind",
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color[GameInfo().groupTurn],
          ),
        ),
      ],
    );
  }
}
