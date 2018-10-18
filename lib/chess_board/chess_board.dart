import 'package:flutter/material.dart';
import 'package:learn_chess/chess_board/board_square.dart';
import 'package:learn_chess/chess_board/chess_board_controller.dart';
import 'package:scoped_model/scoped_model.dart';

class ChessBoard extends StatefulWidget {
  // Defines the length and width of the chess board.
  //final size;

  // Defines the callback on move.
  //final MoveCallback onMove;

  // Defines the callback on checkmate.
  //final CheckMateCallback onCheckMate;

  // Defines the callback on draw.
  //final VoidCallback onDraw;

  // Defines what orientation to draw the board.
  // If the user is white, the white pieces face the user.
  // final bool whiteSideTowardsUser;

  // A Controller to make programmatic moves instead of drag-and-drop.
  //final ChessBoardController chessBoardController;

  // Disables the chessboard from user moves when set to false;
//  final bool enableUserMoves;
//
//  ChessBoard(
//      {this.size = 200.0,
//      //  this.whiteSideTowardsUser = true,
////        @required this.onMove,
////        @required this.onCheckMate,
////        @required this.onDraw,
////        this.chessBoardController,
//        this.enableUserMoves = true});

  @override
  _ChessBoardState createState() => _ChessBoardState();
}

class _ChessBoardState extends State<ChessBoard> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return ScopedModel<ChessBoardController>(
      model: ChessBoardController(),
      child: Container(
        height: width,
        width: width,
        child: Stack(
          // The base chessboard image
          children: <Widget>[
            Container(
              height: width,
              width: width,
              child: Image.asset(
                "images/chess_board.png",
              ),
            ),

            //Overlaying draggables/ dragTargets onto the squares
            Container(
              height: width,
              width: width,
              child: Table(
                children: buildBoard(squareWidth: width / 8),
                // height: width,
                // width: width,
                //child: buildChessBoard(),
              ),
            )
          ],
        ),
      ),
    );
  }

  void refreshBoard() {
    setState(() {});
//    if (game.in_checkmate) {
//      widget.onCheckMate(game.turn == chess.Color.WHITE ? "Black" : "White");
//    } else if (game.in_draw || game.in_stalemate) {
//      widget.onDraw();
//    }
  }

  List<TableRow> buildBoard({double squareWidth}) {
    //from white perspective
    var squareList = [
      [
        "a8",
        "b8",
        "c8",
        "d8",
        "e8",
        "f8",
        "g8",
        "h8",
      ],
      [
        "a7",
        "b7",
        "c7",
        "d7",
        "e7",
        "f7",
        "g7",
        "h7",
      ],
      [
        "a6",
        "b6",
        "c6",
        "d6",
        "e6",
        "f6",
        "g6",
        "h6",
      ],
      [
        "a5",
        "b5",
        "c5",
        "d5",
        "e5",
        "f5",
        "g5",
        "h5",
      ],
      [
        "a4",
        "b4",
        "c4",
        "d4",
        "e4",
        "f4",
        "g4",
        "h4",
      ],
      [
        "a3",
        "b3",
        "c3",
        "d3",
        "e3",
        "f3",
        "g3",
        "h3",
      ],
      [
        "a2",
        "b2",
        "c2",
        "d2",
        "e2",
        "f2",
        "g2",
        "h2",
      ],
      [
        "a1",
        "b1",
        "c1",
        "d1",
        "e1",
        "f1",
        "g1",
        "h1",
      ],
    ];

    return squareList.map((row) {
      return TableRow(
          children: row.map((square) {
        return BoardSquare(squareName: square, squareWidth: squareWidth);
      }).toList());
    }).toList();
  }
}
