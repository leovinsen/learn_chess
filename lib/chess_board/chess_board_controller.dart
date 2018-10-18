import 'package:chess/chess.dart';
import 'package:flutter/material.dart';
import 'package:learn_chess/chess_board/board_square.dart';
import 'package:scoped_model/scoped_model.dart';

class ChessBoardController extends Model {
  //w for white, b for black
  final Chess chess = Chess();
  //final double size;
  String turn = 'W';
  Map<String, Function(bool)> mapOfBoardSquares = {};
  VoidCallback _unselectLastSquare;
  List _currentShownLegalMoves = [];

 // ChessBoardController(this.size);

  static ChessBoardController of(BuildContext context) =>
      ScopedModel.of<ChessBoardController>(context);

  String getPieceName(String square){
    Piece piece = chess.get(square);
    return piece != null ? (piece.color.toString() + piece.type.name).toUpperCase() : null;
  }

  void select(VoidCallback s){
    if(_unselectLastSquare != null) _unselectLastSquare();

    _unselectLastSquare = s;
  }

  void generateLegalMoves(String squareName){
    _currentShownLegalMoves = chess.moves({
      'square' : squareName,
      'verbose' : true
    });
    print(_currentShownLegalMoves);
    _currentShownLegalMoves.forEach((entry){
      mapOfBoardSquares[entry['to']](true);
    });
  }

  bool isAnyPieceSelected(){
    return _unselectLastSquare != null;
  }

  void removeLastLegalMoves(){
    _currentShownLegalMoves.forEach((entry){
      mapOfBoardSquares[entry['to']](false);
    });
  }

  void addBoardSquare(String squareName, Function(bool) callback){
    mapOfBoardSquares[squareName] = callback;
  }

  void makeMove(){

  }

}