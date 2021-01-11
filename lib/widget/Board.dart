import 'package:flutter/cupertino.dart';

import 'Card.dart';
import '../Const.dart';

class Board extends StatelessWidget {
  final Function onChoose;

  Board({
    @required this.onChoose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 390,
      width: 390,
      child: GridView.count(
        scrollDirection: Axis.horizontal,
        crossAxisCount: 5,
        shrinkWrap: false,
        children: List.generate(
          words.length,
          (index) => MyCard(
            word: words[index],
            onChoose: onChoose,
          ),
        ),
      ),
    );
  }
}
