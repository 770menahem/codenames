import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newkodenames/obj/GroupPoint.dart';
import 'package:newkodenames/obj/words.dart';

class CaptainMap extends StatelessWidget {
  final List<WordObj> words = GameInfo().words;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: 160,
      color: Colors.blueGrey,
      child: GridView.count(
        scrollDirection: Axis.horizontal,
        crossAxisCount: 5,
        shrinkWrap: false,
        children: List.generate(
          words.length,
          (index) => Container(
            margin: EdgeInsets.all(2),
            color: words[index].color,
          ),
        ),
      ),
    );
  }
}
