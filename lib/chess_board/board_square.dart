import 'package:chess_vectors_flutter/chess_vectors_flutter.dart';
import 'package:flutter/material.dart';
import 'package:learn_chess/chess_board/chess_board_controller.dart';
import 'package:scoped_model/scoped_model.dart';

class BoardSquare extends StatefulWidget {
  final String squareName;
  final double squareWidth;
  const BoardSquare({this.squareName, this.squareWidth});


  @override
  _BoardSquareState createState() => _BoardSquareState();
}

class _BoardSquareState extends State<BoardSquare> {
  ChessBoardController _controller;
  bool _selected = false;
  bool _legalMoveIndicator = false;

  @override
  void initState() {
    super.initState();
    _controller = ChessBoardController.of(context);
    _controller.addBoardSquare(widget.squareName, showTileAsLegalMoveIndicator);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ChessBoardController>(
      builder: (_, child, model){
        String pieceName = _controller.getPieceName(widget.squareName);
        return Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            Container(child: _legalMoveIndicatorDot()),
            GestureDetector(
              onTap: ()=> _isSelectable(pieceName, model.turn) ? _selectTile() : null,
              child: Container(
                color: _selected ? Colors.yellowAccent.shade200.withAlpha(120) : null,
                height: widget.squareWidth,
                width: widget.squareWidth,
                child: _getPieceImage(pieceName),
              ),
            ),
          ],

        );
      },
    );
  }

  Widget _legalMoveIndicatorDot(){
    return _legalMoveIndicator
        ? CircleAvatar(backgroundColor: Colors.black.withAlpha(100),radius: widget.squareWidth/6,)
        : null;
  }

  void _unselect(){
    setState(() {
      _selected = false;
    });
  }

  void _selectTile(){

    //First, check is a square is currently selected (refer to lastSlectedSquare)
    //If true, check if the target is in the legal move
        //If legal, perform the legal move
    //Else, check if the square is selectable

    if(_controller.isAnyPieceSelected()){

    }

    _controller.removeLastLegalMoves();
    _controller.generateLegalMoves(widget.squareName);
    _controller.select(_unselect);
    setState(() {
      _selected = true;
    });
  }

  bool _isSelectable(String pieceName, String whoseTurn){
    if(pieceName == null) return false;

    return pieceName.substring(0,1) == whoseTurn;
  }

  void showTileAsLegalMoveIndicator(bool b){
    setState(() {
      _legalMoveIndicator = b;
    });
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
}
