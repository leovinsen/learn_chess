import 'package:chess/chess.dart';
import 'package:flutter/material.dart' hide State;
import 'package:scoped_model/scoped_model.dart';

class ChessBoardController extends Model {
  final String fen;
  Chess chess;
  ChessBoardController([this.fen]){
    chess = fen == null ? Chess() : Chess.fromFEN(fen);
  }

  Map<String, Function(bool)> legalMoveIndicatorFunctions = {};
  VoidCallback _deselectSelectedSquare;
  String _selectedSquare;
  List _currentShownLegalMoves = [];
  List _moveHistorySAN = [];
  List get history => _moveHistorySAN;

  List<State> getHistory(){
    return chess.history;
  }

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


  void addBoardSquare(String squareName, Function(bool) callback){
    legalMoveIndicatorFunctions[squareName] = callback;
  }

  void handleUserTap(String squareName){
//    if(isAnyPieceSelected() && isTargetLegalMove(squareName)){
//      makeMove(squareName);
//    } else if () {
//
//    }
//    if(_controller.isAnyPieceSelected() && _controller.isTargetLegalMove(widget.squareName)){
//      _controller.makeMove(widget.squareName);
//    } else if(pieceName?.substring(0,1) == whoseTurn){
//      _controller.selectTile(_deselectThisTile, widget.squareName);
//      _selectThisTile();
//    }
  }

  void makeMove(String san){
    if(san == null) return;

//    chess.move({
//      'from' : _selectedSquare,
//      'to' : squareName
//    });
    chess.move(san);
    storeMove(san);

    removeOldLegalMoveIndicators();
    deselectLastSquare();

    updateBoard();
  }

  void storeMove(String san){
    _moveHistorySAN.add(san);
  }

  void undoMove(){
    chess.undo_move();
    notifyListeners();
  }

  void deselectLastSquare(){
    _deselectSelectedSquare();
    _deselectSelectedSquare = null;
    _selectedSquare = null;
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

  String isTargetLegalMove(String squareName){

    for(int i = 0; i < _currentShownLegalMoves.length; i++){
      Map map = _currentShownLegalMoves[i];
      if(map['to'] == squareName) {
        return map['san'];
      }
    }
    return null;
  }
//  bool isTargetLegalMove(String squareName){
//    //bool b = false;
//
//    for(int i = 0; i < _currentShownLegalMoves.length; i++){
//      Map map = _currentShownLegalMoves[i];
//      if(map['to'] == squareName) {
//        return true;
//      }
//    }
//    return false;
//  }


  static ChessBoardController of(BuildContext context) =>
      ScopedModel.of<ChessBoardController>(context);




}