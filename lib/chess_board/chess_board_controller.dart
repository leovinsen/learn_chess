import 'package:chess/chess.dart' as chesslib;
import 'package:flutter/material.dart';
import 'package:learn_chess/chess_board/board_square.dart';
import 'package:scoped_model/scoped_model.dart';

class ChessBoardController extends Model {
  final String fen;
  final Function showPromotionDialog;
  chesslib.Chess _chess;
  ChessBoardController({this.fen, this.showPromotionDialog}) : assert(showPromotionDialog != null){
    _chess = fen == null ? chesslib.Chess() : chesslib.Chess.fromFEN(fen);
  }

  Map<String, BoardSquareState> boardSquareStates = {};

 // Map<String, Function(bool)> legalMoveIndicatorFunctions = {};
 // VoidCallback _deselectSelectedSquare;
  String _selectedSquare;
  List _currentShownLegalMoves = [];
  List _moveHistorySAN = [];
  List get history => _moveHistorySAN;

  List<chesslib.State> getHistory(){
    return _chess.history;
  }

  void addBoardState(String squareName, State boardState){
    boardSquareStates[squareName] = boardState;
  }

  void _selectTile(String squareName){
    if(_selectedSquare != null) boardSquareStates[_selectedSquare].toggleSelection(false);
    boardSquareStates[squareName].toggleSelection(true);

    _selectedSquare = squareName;
    removeOldLegalMoves();
    generateNewLegalMoves(squareName);
  }

  void removeOldLegalMoves(){
    _currentShownLegalMoves.forEach((entry){
      boardSquareStates[entry['to']].toggleLegalMoveIndicator(false);
      //legalMoveIndicatorFunctions[entry['to']](false);
    });
  }

  void generateNewLegalMoves(String squareName){
    _currentShownLegalMoves = _chess.moves({
      'square' : squareName,
      'verbose' : true
    });
    print(_currentShownLegalMoves);
    _currentShownLegalMoves.forEach((entry){
      boardSquareStates[entry['to']].toggleLegalMoveIndicator(true);
    });
  }

  void handleUserTap(String squareName, String pieceName){
    if(_selectedSquare!= null){
      makeMove(isTargetLegalMove(squareName));
    } else if (pieceName?.substring(0,1) == getPlayerTurn()){
      _selectTile(squareName);
    }
  }

  void makeMove(String san){
    if(san == null) return;

    _chess.move(san);
    _moveHistorySAN.add(san);
    _cleanup();
    _updateBoard();
  }

  void _cleanup(){
    removeOldLegalMoves();
    boardSquareStates[_selectedSquare].toggleSelection(false);
    _selectedSquare = null;
  }

  void undoMove(){
    _chess.undo_move();
    notifyListeners();
  }

  void _updateBoard() {
    if (_chess.in_checkmate) {
      print('CHECKMATE!!!!');
    } else if (_chess.in_check) {
      print('Checkhu');
    } else if (_chess.in_stalemate) {
      print('Stalemate');
    }

    notifyListeners();
  }

  String getPlayerTurn(){
    return _chess.turn.toString().toUpperCase();
  }


  String getPieceName(String square){
    chesslib.Piece piece = _chess.get(square);
    return piece != null ? (piece.color.toString() + piece.type.name).toUpperCase() : null;
  }

  String isTargetLegalMove(String squareName){

    for(int i = 0; i < _currentShownLegalMoves.length; i++){
      Map map = _currentShownLegalMoves[i];

      //Move is legal
      if(map['to'] == squareName) {
        //Determine if it is a promotion
        if((map['flags'] as String).contains('p')){
          showPromotionDialog();
        }
//        String san = map['san'];
//        if(san)
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