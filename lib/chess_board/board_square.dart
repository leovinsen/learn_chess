import 'package:chess_vectors_flutter/chess_vectors_flutter.dart';
import 'package:flutter/material.dart';
import 'package:learn_chess/chess_board/chess_board_controller.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/foundation.dart';

class BoardSquare extends StatefulWidget {
  final String squareName;
  final double squareWidth;
  final bool enableMovement;
  const BoardSquare({@required this.squareName, @required this.squareWidth, @required this.enableMovement})
      : assert(squareName != null), assert(squareWidth != null), assert(enableMovement != null);


  @override
  BoardSquareState createState() => BoardSquareState();
}

class BoardSquareState extends State<BoardSquare> {

  ChessBoardController _controller;
  bool _selected;
  bool _legalMoveIndicator;

  @override
  void initState() {
    super.initState();
    _selected = false;
    _legalMoveIndicator = false;
    _controller = ChessBoardController.of(context);
    _controller.addBoardState(widget.squareName, this);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ChessBoardController>(
      builder: (_, child, model){
        String pieceName = _controller.getPieceName(widget.squareName);
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: ()=> widget.enableMovement
          ? _controller.handleUserTap(widget.squareName, pieceName)
//              ? _handleUserTap(pieceName, model.getPlayerTurn())
              : null ,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              _legalMoveIndicatorDot(),
              Container(
                color: _selected
                    ? Colors.yellowAccent.shade200.withAlpha(120)
                    : null,
                height: widget.squareWidth,
                width: widget.squareWidth,
                child: _getPieceImage(pieceName),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _getPieceImage(String pieceName){
    if (pieceName == null) return null;

    Widget imageToDisplay;
    switch (pieceName) {
      case "WP":
        imageToDisplay = WhitePawn(size: widget.squareWidth);
        break;
      case "WR":
        imageToDisplay = WhiteRook(size: widget.squareWidth);
        break;
      case "WN":
        imageToDisplay = WhiteKnight(size: widget.squareWidth);
        break;
      case "WB":
        imageToDisplay = WhiteBishop(size: widget.squareWidth);
        break;
      case "WQ":
        imageToDisplay = WhiteQueen(size: widget.squareWidth);
        break;
      case "WK":
        imageToDisplay = WhiteKing(size: widget.squareWidth);
        break;
      case "BP":
        imageToDisplay = BlackPawn(size: widget.squareWidth);
        break;
      case "BR":
        imageToDisplay = BlackRook(size: widget.squareWidth);
        break;
      case "BN":
        imageToDisplay = BlackKnight(size: widget.squareWidth);
        break;
      case "BB":
        imageToDisplay = BlackBishop(size: widget.squareWidth);
        break;
      case "BQ":
        imageToDisplay = BlackQueen(size: widget.squareWidth);
        break;
      case "BK":
        imageToDisplay = BlackKing(size: widget.squareWidth);
        break;
      default:
        imageToDisplay = WhitePawn(size: widget.squareWidth);
    }
    return imageToDisplay;
  }

  Widget _legalMoveIndicatorDot(){
    return _legalMoveIndicator
        ? CircleAvatar(backgroundColor: Colors.black.withAlpha(100),radius: widget.squareWidth/6,)
        : Container();
  }

  void toggleSelection(bool b){
    setState(() {
      _selected = b;
    });
  }

  void toggleLegalMoveIndicator(bool b){
    setState(() {
      _legalMoveIndicator = b;
    });
  }

}