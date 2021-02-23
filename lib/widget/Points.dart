import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newkodenames/obj/GroupPoint.dart';
import 'package:provider/provider.dart';

import '../Const.dart';

class Points extends StatelessWidget {
  points(Color color, int times) {
    return Column(
      children: [
        for (var i = times; i > 0; i--)
          Column(
            children: [
              Container(
                height: 10,
                width: 20,
                color: color,
              ),
              SizedBox(
                height: 5,
              )
            ],
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final pointBlue = Provider.of<GameInfo>(context).pointsBlue;
    final pointRed = Provider.of<GameInfo>(context).pointsRed;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        points(color[0], pointBlue),
        points(color[1], pointRed),
      ],
    );
  }
}
