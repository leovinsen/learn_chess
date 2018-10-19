import 'package:chess/chess.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ChessBoardController extends Model {
  final Chess chess = Chess();
  Map<String, Function(bool)> legalMoveIndicatorFunctions = {};
  VoidCallback _deselectSelectedSquare;
  String _selectedSquare;
  List _currentShownLegalMoves = [];


  void selectTile(VoidCallback deselectCallback, String square){
    if(_deselectSelectedSquare != null) _deselectSelectedSquare();

    _deselectSelectedSquare = deselectCallback;
    _selectedSquare = square;

    removeOldLegalMoveIndicators();
    generateNewLegalMoves(square);
    generateNewLegalMoveIndicators();
  }

  void removeOldLegalMoveIndicators(){
    _currentShownLegalMoves.forEach((entry){
      legalMoveIndicatorFunctions[entry['to']](false);
    });
  }

  void generateNewLegalMoves(String squareName){
    _currentShownLegalMoves = chess.moves({
      'square' : squareName,
      'verbose' : true
    });
  }

  void generateNewLegalMoveIndicators(){
    print(_currentShownLegalMoves);
    _currentShownLegalMoves.forEach((entry){
      legalMoveIndicatorFunctions[entry['to']](true);
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


  void addBoardSquare(String squareName, Function(bool) callback){
    legalMoveIndicatorFunctions[squareName] = callback;
  }

  void makeMove(String squareName){
    print('Moving to $squareName');

    chess.move({
      'from' : _selectedSquare,
      'to' : squareName
    });

    removeOldLegalMoveIndicators();
    _deselectSelectedSquare();

    _deselectSelectedSquare = null;
    _selectedSquare = null;

    updateBoard();
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

  String getPlayerTurn(){
    return chess.turn.toString().toUpperCase();
  }


  bool isAnyPieceSelected(){
    return _deselectSelectedSquare != null;
  }

  String getPieceName(String square){
    Piece piece = chess.get(square);
    return piece != null ? (piece.color.toString() + piece.type.name).toUpperCase() : null;
  }

  static ChessBoardController of(BuildContext context) =>
      ScopedModel.of<ChessBoardController>(context);




}