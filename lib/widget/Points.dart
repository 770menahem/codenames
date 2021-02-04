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
    final point = Provider.of<GameInfo>(context).points;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        points(color[0], point[0]),
        points(color[1], point[1]),
      ],
    );
  }
}
