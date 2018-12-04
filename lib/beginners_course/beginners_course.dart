import 'package:flutter/material.dart';
import 'package:learn_chess/beginners_course/checkmate_guide.dart';
import 'package:learn_chess/beginners_course/guide_page_template.dart';
import 'package:learn_chess/beginners_course/pieces_guide.dart';
import 'helper.dart';

class BeginnersCourse extends StatelessWidget {

  final List _enPassant = [
    "En Passant is French for 'in passing'",
    "If a pawn moves two squares on its initial move and lands to the side of an opponent pawn. By doing so the opponent's pawn cannot capture that pawn."
        "The en passant rule allows the opposing pawn to capture the pawn that had just moved two squares as if the pawn had just moved one square, thus allowing for a capture."
        "In doing so, the other pawn will seem to 'pass through' when capturing. "
        "However, this move must be performed immediately on the next turn, otherwise the option to capture will be lost.",
  ];

  final List _castling =[
    "Castling is a special move which allows you to move your king AND your rook at the same time. On a player's turn, they may"
      "move their king two squares over towards a rook and that rook moves to the square on the other side of the king. The resulting position"
      "is illustrated above. This is called 'castling kingside' because the king 'castles' towards the rook on his side.",
    "If the castle is performed towards the rook on the queen's side, it is called 'castling queenside'. Regardless of which side you chose,"
      "The king always moves two squares when castling.",
    "However, there are many requirements for a castle to happen. They are: \n"
    "1. The king must not have moved before. \n",
    "2. The rook must not have moved before. \n",
    "3. There must not be any pieces between the king and the rook. \n",
    "4. The king must not pass through or end up on a square that is under attack. \n"
  ];

  List _data = [
    //["Board Setup", BoardSetupGuide()],
    //["Chess Pieces", PieceGuide()],
    //["How to Play", ConceptsGuide()],
  ];

  List<String> boardSetup = [

    'At the beginning, the chess board is laid out so that the white square is in the bottom right-hand side. Top is black\'s side and bottom is white\'s side ',
    'Then, the second row of each side is filled with pawns.',
    'Followed by the rooks at the corner of each side ...',
    '... and the knights next to them ...',
    '... and the bishops ...',
    '... and the queen on the square that matches her color...',
    '... and finally, the king on the remaining square.'
  ];

  //Empty, pawns, rooks, knights, bishops, queen, king
  List<String> boardSetupFEN = [
    '8/8/8/8/8/8/8/8 w - - 0 1',
    '8/pppppppp/8/8/8/8/PPPPPPPP/8 w - - 0 1',
    'r6r/pppppppp/8/8/8/8/PPPPPPPP/R6R w - - 0 1',
    'rn4nr/pppppppp/8/8/8/8/PPPPPPPP/RN4NR w - - 0 1',
    'rnb2bnr/pppppppp/8/8/8/8/PPPPPPPP/RNB2BNR w - - 0 1',
    'rnbq1bnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQ1BNR w - - 0 1',
    'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w - - 0 1'
  ];


  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    List<Widget> _enPassantContent = [
      pageWithCenter(_enPassant[0]),
      pageWithBoard(_enPassant[1], context)
    ];

    _data..add([
      "Board Setup",
      GuidePageTemplate(
        title: "Board Setup", content: [0, 1, 2, 3, 4, 5, 6].map((int index) {
        return pageWithBoard(boardSetup[index], context, boardSetupFEN[index]);
      }).toList())
    ])

      ..add(["Chess Pieces", PieceGuide()])
      ..add(["How to Play", ConceptsGuide()])
      ..add([
      "En Passant",
      GuidePageTemplate(title: "En Passant", content: _enPassantContent)
    ]);



    return ListView.separated(
      padding: const EdgeInsets.all(10.0),
      itemCount: _data.length,
      //crossAxisAlignment: CrossAxisAlignment.stretch,
      itemBuilder: (_, index) {
        return GestureDetector(
          child: ListTile(
            title: Text(
              _data[index][0],
              style: textTheme.headline,
            ),
          ),
          onTap: createCallback(context, _data[index][1]),
        );
      },
      separatorBuilder: (_, index) {
        return Divider();
      },
    );

  }
}
