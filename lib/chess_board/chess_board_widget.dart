import 'package:flutter/material.dart';
import 'package:learn_chess/chess_board/board_square.dart';
import 'package:learn_chess/chess_board/chess_board_controller.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:chess_vectors_flutter/chess_vectors_flutter.dart';

class ChessBoardWidget extends StatelessWidget {
  final String initialPositionFEN;
  final bool enableMovement;
  final double boardWidth;
  final bool showHUD;

  ChessBoardWidget(
      {@required this.showHUD,
      @required this.enableMovement,
      @required this.boardWidth,
      this.initialPositionFEN})
      : assert(enableMovement != null),
        assert(boardWidth != null),
        assert(showHUD != null);

  ChessBoardController _controller;

  @override
  Widget build(BuildContext context) {
    _controller = ChessBoardController(boardSetupFEN: initialPositionFEN, showPromotionDialog: ()=> createDialog(context));
    final boardBackground = Container(
      height: boardWidth,
      width: boardWidth,
      child: Image.asset(
        "images/chess_board.png",
      ),
    );

    //Since there are 8x8 squares, each square's length and width will be exactly boardWidth/8
    final boardSquares = Container(
      height: boardWidth,
      width: boardWidth,
      child: Table(
        children: buildBoard(boardWidth / 8),
      ),
    );

    final chessBoard = Container(
      height: boardWidth,
      width: boardWidth,
      child: Stack(
        children: <Widget>[
          boardBackground,
          boardSquares
        ],
      ),
    );

//    final model = ChessBoardController(fen: initialPositionFEN, showPromotionDialog: ()=> createDialog(context));

//    final hud = Row(
//      children: <Widget>[
//        Expanded(
//          flex: 1,
//          child: IconButton(
//            icon: Icon(Icons.keyboard_arrow_left),
//            onPressed: () => model.undoMove(),
//            tooltip: 'Undo',
//          ),
//        ),
//        Expanded(
//          flex: 1,
//          child: IconButton(
//            icon: Icon(Icons.keyboard_arrow_right),
//            onPressed: () => print(model.history.toString())
//          ),
//        )
//      ],
//    );
//
//    final history = Container(
//      child: Text(model.history.toString()),
//    );

   // final history =


    return ScopedModel<ChessBoardController>(
      model: _controller,
      child: ScopedModelDescendant<ChessBoardController>(
        builder: (_, child, model){
          return Column(children: <Widget>[
            chessBoard,
            showHUD ? ChessHUD(undoMove: model.undoMove, history: model.history.toString(),) : Container()
          ]);
        },
//        ]),
      ),
    );
  }

  List<TableRow> buildBoard(double squareWidth) {
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
        return BoardSquare(
          squareName: square,
          squareWidth: squareWidth,
          enableMovement: enableMovement,
        );
      }).toList());
    }).toList();
  }

  Future<String> createDialog(BuildContext context) async {

    String playerTurn = _controller.getPlayerTurn();
      return await showDialog(
        barrierDismissible: false,
          context: context,
          builder: (_){
            return AlertDialog(
                title: Text('Promotion'),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  InkWell(
                    child: isWhite(playerTurn) ? WhiteQueen() : BlackQueen(),
                    onTap: () => Navigator.of(context).pop('Q'),
                  ),
                  InkWell(
                    child: isWhite(playerTurn) ? WhiteBishop() : BlackBishop(),
                    onTap: () => Navigator.of(context).pop('B'),
                  ),
                  InkWell(
                    child: isWhite(playerTurn) ? WhiteRook() : BlackRook(),
                    onTap: () => Navigator.of(context).pop('R'),
                  ),
                  InkWell(
                    child: isWhite(playerTurn) ? WhiteKnight() : BlackKnight(),
                    onTap: () => Navigator.of(context).pop('N'),
                  )
                ],
              ),
            );
          }
      );
    }


  bool isWhite(String playerTurn){
    return playerTurn.startsWith('W') ? true : false;
  }
}

class ChessHUD extends StatelessWidget {
  final Function undoMove;
  String history;

  ChessHUD({@required this.undoMove, @required this.history}) : assert(undoMove != null), assert(history != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: IconButton(
                icon: Icon(Icons.keyboard_arrow_left),
                onPressed: () => undoMove(),
                tooltip: 'Undo',
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                  icon: Icon(Icons.keyboard_arrow_right),
                  onPressed: () => null),
            )
          ],
        ),
        Container(
          child: Text(history),
        )
      ],
    );
  }
}

