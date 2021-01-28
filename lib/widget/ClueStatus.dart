import 'package:flutter/cupertino.dart';
import 'package:newkodenames/obj/GroupPoint.dart';
import 'package:provider/provider.dart';

import '../Const.dart';

class ClueStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final numToFind = Provider.of<GroupPoint>(context).wordToFind;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          "רמז: ${GroupPoint().clue}",
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color[groupTurn],
          ),
        ),
        Text(
          (hasLeft && numToFind > 1)
              ? "מספר: ${numToFind - 1} + 1"
              : "מספר: $numToFind",
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color[groupTurn],
          ),
        ),
      ],
    );
  }
}
