import 'package:flutter/material.dart';
import 'package:learn_chess/beginners_course/guide_page_template.dart';
import 'package:learn_chess/chess_board/chess_board_widget.dart';
import 'styling.dart';

class BoardSetupGuide extends StatefulWidget {
  @override
  BoardSetupGuideState createState() {
    return new BoardSetupGuideState();
  }
}

class BoardSetupGuideState extends State<BoardSetupGuide>{

  TextTheme textTheme;
  double boardWidth;

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    boardWidth = MediaQuery.of(context).size.width - pageHorizontalPadding * 2;
    textTheme = Theme
        .of(context)
        .textTheme
        .apply(bodyColor: Colors.white);
    return GuidePageTemplate(title: 'Board setup', content: [0,1,2,3,4,5,6].map((int index){
                        return pageWidgetBuilder(fenList[index], content[index]);
                      }).toList(),
    );
  }

  Widget pageWidgetBuilder(String fen, String content){

    return Column(
      children: <Widget>[
        ChessBoardWidget(boardWidth: boardWidth, enableMovement: false, showHUD: false, initialPositionFEN: fen,),
        //ChessBoard(width: boardWidth, enableMovement: false, fen: fen,),
        SizedBox(height: 20.0,),
        Text(content , style: textTheme.title, textAlign: TextAlign.center,)
      ],
    );

  }

  List<String> content = [

    'At the beginning, the chess board is laid out so that the white square is in the bottom right-hand side. Top is black\'s side and bottom is white\'s side ',
    'Then, the second row of each side is filled with pawns.',
    'Followed by the rooks at the corner of each side ...',
    '... and the knights next to them ...',
    '... and the bishops ...',
    '... and the queen on the square that matches her color...',
    '... and finally, the king on the remaining square.'
  ];

  //Empty, pawns, rooks, knights, bishops, queen, king
  List<String> fenList = [
    '8/8/8/8/8/8/8/8 w - - 0 1',
    '8/pppppppp/8/8/8/8/PPPPPPPP/8 w - - 0 1',
    'r6r/pppppppp/8/8/8/8/PPPPPPPP/R6R w - - 0 1',
    'rn4nr/pppppppp/8/8/8/8/PPPPPPPP/RN4NR w - - 0 1',
    'rnb2bnr/pppppppp/8/8/8/8/PPPPPPPP/RNB2BNR w - - 0 1',
    'rnbq1bnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQ1BNR w - - 0 1',
    'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w - - 0 1'
  ];

}
