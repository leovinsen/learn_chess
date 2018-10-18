import 'package:chess/chess.dart';
import 'package:flutter/material.dart';
import 'package:learn_chess/chess_board/board_square.dart';
import 'package:scoped_model/scoped_model.dart';

class ChessBoardController extends Model {
  final Chess chess = Chess();
  //String turn = 'W';
  Map<String, Function(bool)> mapOfBoardSquares = {};
  VoidCallback _unselectSelectedSquare;
  String _selectedSquare;
  List _currentShownLegalMoves = [];

  static ChessBoardController of(BuildContext context) =>
      ScopedModel.of<ChessBoardController>(context);

  String getPieceName(String square){
    Piece piece = chess.get(square);
    return piece != null ? (piece.color.toString() + piece.type.name).toUpperCase() : null;
  }

  void select(VoidCallback s, String square){
    if(_unselectSelectedSquare != null) _unselectSelectedSquare();

    _unselectSelectedSquare = s;
    _selectedSquare = square;
    removeLastLegalMoves();
    generateLegalMoves(square);


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

  bool isTargetLegalMove(String squareName){
    bool b = false;

    for(int i = 0; i < _currentShownLegalMoves.length; i++){
      Map map = _currentShownLegalMoves[i];
      if(map['to'] == squareName) {
        b = true;
        break;
      }
    }
    return b;
  }

  bool isAnyPieceSelected(){
    return _unselectSelectedSquare != null;
  }

  void removeLastLegalMoves(){
    _currentShownLegalMoves.forEach((entry){
      mapOfBoardSquares[entry['to']](false);
    });
  }

  void addBoardSquare(String squareName, Function(bool) callback){
    mapOfBoardSquares[squareName] = callback;
  }

  void makeMove(String squareName){
    print('Moving to $squareName');

    chess.move({
      'from' : _selectedSquare,
      'to' : squareName
    });

    //turn = chess.turn.toString().toUpperCase();
    removeLastLegalMoves();
    _unselectSelectedSquare();
    _unselectSelectedSquare = null;

    _selectedSquare = null;

    updateBoard();

  }

  String getPlayerTurn(){
    return chess.turn.toString().toUpperCase();
  }

  void updateBoard() {
    if (chess.in_checkmate) {
      print('CHECKMATE!!!!');
    } else if (chess.in_check) {
      print('Checkhu');
    } else if (chess.in_stalemate) {
      print('Salemaetett');
    }

    notifyListeners();
  }

}