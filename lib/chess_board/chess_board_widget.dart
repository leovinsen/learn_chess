import 'package:flutter/material.dart';
import 'package:learn_chess/chess_board/board.dart';
import 'package:learn_chess/chess_board/board_square.dart';
import 'package:learn_chess/chess_board/chess_board_controller.dart';
import 'package:learn_chess/chess_board/chess_board_hud.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:chess_vectors_flutter/chess_vectors_flutter.dart';

///Parent for the whole Chess Board widgets
class ChessBoardWidget extends StatelessWidget {

  ///FEN stands for Forsyth–Edwards Notation, a standard notation used to describe a particular
  final String initialPositionFEN;

  ///If false is provided, interaction with the chess board will be disabled
  final bool enableMovement;

  ///Width of widget
  final double boardWidth;

  ///If false is provided, disable HUD
  final bool showHUD;

  ChessBoardWidget(
      {@required this.showHUD,
      @required this.enableMovement,
      @required this.boardWidth,
      this.initialPositionFEN})
      : assert(enableMovement != null),
        assert(boardWidth != null),
        assert(showHUD != null);

  ///Controller responsible for calculating all logic
  ChessBoardController _controller;

  @override
  Widget build(BuildContext context) {
    _controller = ChessBoardController(
        boardSetupFEN: initialPositionFEN,
        onPromotion: () => showPromotionDialog(context),
      onCheckmate: () => showGameOverDialog(context, "checkmate"),
      onStalemate: () => showGameOverDialog(context, "stalemate")
    );

    return ScopedModel<ChessBoardController>(
      model: _controller,
      child: ScopedModelDescendant<ChessBoardController>(
        builder: (_, child, model) {
          return Column(children: <Widget>[
            Board(boardWidth, enableMovement),
            showHUD
                ? ChessHUD(
                    undoMove: model.undoMove,
                    history: model.history,
                  )
                : Container()
          ]);
        },
      ),
    );
  }

  ///Shows a promotion dialog in which user can choose what piece to promote to.
  ///Available options are: queens, rooks, bishops and knights.
  Future<String> showPromotionDialog(BuildContext context) async {

    ///Used to determine the color of the pieces
    String playerTurn = _controller.getPlayerTurn();

    return await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
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
        });
  }

  ///Called when the game is over (checkmate or stalemate)
  ///Gives the user options to either start a new game or undo (to allow players to change the outcome of the game
  Future<bool> showGameOverDialog(BuildContext context, String result) async {
    String title;
    if(result == "checkmate") {
      title = "Checkmate!";
    } else if (result == "stalemate") {
      title = "Stalemate!";
    }

    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(title),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                color: Theme.of(context).primaryColor,
                child: Text('Play Again'),
                onPressed: () => Navigator.of(context).pop(true) ,
              ),
              FlatButton(
                child: Text('Undo'),
                onPressed: ()=> Navigator.of(context).pop(false),
              )
            ],
          ),
        );
      }
    );

  }


  ///Helper method that returns true if player turn is white
  bool isWhite(String playerTurn) {
    return playerTurn.startsWith('W') ? true : false;
  }
}
