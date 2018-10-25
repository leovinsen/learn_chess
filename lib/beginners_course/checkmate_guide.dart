import 'package:flutter/material.dart';
import 'package:learn_chess/beginners_course/helper.dart';
//
//List contents =
//[
//  //Attacking
//  [
//    'To attack a piece is to position your piece(s) on a square where they can capture the opposing piece on the following turn.',
//    'For example, by moving the knight to Nc3, you are threatening to capture the pawn on e4 if the opponent does not do anything to stop it.',
//    'You can also think of it as putting pressure on the opponent to react to your move.'
//  ],
//
//  //Defending
//  [
//    'To defend a piece is simply reacting to the opponent\'s offensive moves.',
//    'Although it sounds very easy, keep in mind that what may seem to be a defensive move, might also turn out to be an offensive move at the same time.',
//    'To illustrate this, take at the example above...'
//  ],
//
//  //Checkmate
//  [
//    'A game of chess ends with either a win or a draw.',
//    'To win a game, you have to checkmate the enemy king.',
//    'A checkmate occurs when you check the enemy king and he is unable to get out of the check. A check occurs when the opponent attacks your king with a piece.',
//    'A player MUST move the king out of check, by either one of these three methods: ',
//    '1. You can move the king to a square that is not under attack by enemy piece.',
//    '2. you use your other piece to block the attack.',
//    '3. you can capture the piece that is attacking your king.',
//  ]
//];

List<String> titles = [
  'Basic Attacking',
  'Basic Defending',
  'Check & Checkmate',
];

Map contents = {
  titles[0] : [
    'To attack a piece is to position your piece(s) on a square where they can capture the opposing piece on the following turn.',
    'For example, by moving the knight to Nc3, you are threatening to capture the pawn on e4 if the opponent does not do anything to stop it.',
    'You can also think of it as putting pressure on the opponent to react to your move.'
  ],
  titles[1] : [
    'To defend a piece is simply reacting to the opponent\'s offensive moves.',
    'Although it sounds very easy, keep in mind that what may seem to be a defensive move, might also turn out to be an offensive move at the same time.',
    'To illustrate this, take at the example above...'
  ],

  titles[2] :  [
    'A game of chess ends with either a win or a draw.',
    'To win a game, you have to checkmate the enemy king.',
    'A checkmate occurs when you check the enemy king and he is unable to get out of the check. A check occurs when the opponent attacks your king with a piece.',
    'A player MUST move the king out of check, by either one of these three methods: ',
    '1. You can move the king to a square that is not under attack by enemy piece.',
    '2. you use your other piece to block the attack.',
    '3. you can capture the piece that is attacking your king.',
  ],
};

class CheckmateGuide extends StatelessWidget {
  TextTheme textTheme;
  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(15.0) ,
        child: Column(
          children: titles.map((title){
            return GestureDetector(
              onTap: createCallback(context, title, generateCenters(contents[title])),
              child: CircleAvatar(
                child: Text(title[0]),
              ),
            );
          }).toList()
        ),
      ),
    );
  }

  List<Widget> generateCenters(List<String> content){
    return content.map((text){
      return Center(
        child: Text(text, style: textTheme.title.apply(color: Colors.white), ),
      );
    }).toList();
  }

}
