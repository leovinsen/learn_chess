import 'package:chess_vectors_flutter/chess_vectors_flutter.dart';
import 'package:flutter/material.dart';
import 'package:learn_chess/beginners_course/guide_page_template.dart';

class PieceGuide extends StatelessWidget {

  List<String> pawnContent = [
    'Pawns can only move forward, and only one square at a time. However, they may move two squares at once on their very first move.',
    'This means that once they go forward, there is no going back.',
    'A pawn may capture (eliminate) an opposing piece that is one square diagonally in front of them, but not the ones in front of them.',
    'If there is another piece (both yours and your opponent\'s) directly in front of a pawn, he cannot move past that piece.'
  ];

  List<String> rookContent =[
    'The rook may move as far as it wants to the left, right, top or bottom, but it cannot move past pieces that are in its way.',
    'It may capture an opposing piece by moving into the target\'s square.',
  ];

  List<String> knightContent = [
    'The knight moves differently than other pieces by going two squares at a direction, and then one square at a 90 degree angle which forms an \'L\' shape.',
    'Unlike other pieces, the knight is able to move over other pieces.',
    'The knight captures an opposing piece by moving into the target\'s square.'
  ];
  List<String> bishopContent = [
    'Similar to the rook, it may move as far as it wants to, but only diagonally.',
    'If you observe its movement on a chess board, a bishop can ony move to squares that match its starting square color. As a result, bishops are often called \'light colored bishop\' for bishop that starts on the light colored square (usually white) and dark colored square (usually black/brown).',
  ];
  List<String> queenContent = [
    'The queen is the most powerful piece. She can move as far as she wants, at any direction she wants -- horizontally, vertically, and also diagonally',
    'You can think of her as the combination of a rook and a bishop',
  ];
  List<String> kingContent = [
    'The king is the most important piece, yet a weak one.',
    'He can move at any direction he wants, but only one square at a time.',
    'When a piece moves into a square where it can attack (threaten to capture) the king, the king is said to be in "check" and has to move himself out of danger.',
    'It is also illegal to move the king into a square that is under attack'
  ];



  TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: customTable(context)
      ),
    );
  }

  Widget customTable(BuildContext context){
    List<Widget> pawnWidgets = generatePageWidget(pawnContent);
    List<Widget> rookWidgets = generatePageWidget(rookContent);
    List<Widget> knightWidgets = generatePageWidget(knightContent);
    List<Widget> bishopWidgets = generatePageWidget(bishopContent);
    List<Widget> queenWidgets = generatePageWidget(queenContent);
    List<Widget> kingWidgets = generatePageWidget(kingContent);

    VoidCallback pawnCallback = createCallback(context, 'Pawn', pawnWidgets );
    VoidCallback rookCallback = createCallback(context, 'Rook', rookWidgets );
    VoidCallback knightCallback = createCallback(context, 'Knight', knightWidgets );
    VoidCallback bishopCallback = createCallback(context, 'Bishop', bishopWidgets );
    VoidCallback queenCallback = createCallback(context, 'Queen', queenWidgets );
    VoidCallback kingCallback = createCallback(context, 'King', kingWidgets );


    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              pieceButton('Pawn', pawnCallback),
              pieceButton('Rook', rookCallback),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              pieceButton('Knight', knightCallback),
              pieceButton('Bishop', bishopCallback),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              pieceButton('Queen', queenCallback),
              pieceButton('King', kingCallback)
            ],
          ),
        ],
      ),
    );
  }

  VoidCallback createCallback(BuildContext context, String title, List<Widget> widgets){
    return (){
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => GuidePageTemplate(title: title , content: widgets,)
      ));
    };
  }

  List<Widget> generatePageWidget(List<String> content){
    return content.map((text){
      return Center(
        child: Text(text, style: textTheme.title.apply(color: Colors.white),),
      );
    }).toList();
  }

  Widget pieceButton(String title, Function onTap){
    return Column(
      children: <Widget>[
        InkWell(
          onTap: onTap,
          child: Container(
            child: Transform.translate(
                offset: Offset(0.0, -5.0),
                child: WhitePawn(size: 80.0,)
            ),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    width: 2.0,
                    color: Colors.black54
                )
            ),
          ),
        ),
        Text(title, style: textTheme.title,)
      ],
    );
  }

}

