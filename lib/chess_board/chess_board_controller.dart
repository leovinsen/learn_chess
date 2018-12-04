import 'package:chess/chess.dart' as chesslib;
import 'package:flutter/material.dart';
import 'package:learn_chess/chess_board/board_square.dart';
import 'package:scoped_model/scoped_model.dart';

class ChessBoardController extends Model {
  final String boardSetupFEN;
  final Function onPromotion;
  final Function onCheckmate;
  final Function onStalemate;
  chesslib.Chess _chess;

  ChessBoardController(
      {this.boardSetupFEN, this.onPromotion, this.onCheckmate, this.onStalemate})
      : assert(onPromotion != null),
        assert(onCheckmate != null),
        assert(onStalemate != null) {
    ///Initialize to default position if no setupFEN is provided
    _chess = chesslib.Chess.fromFEN(
        boardSetupFEN ?? chesslib.Chess.DEFAULT_POSITION);
  }

  ///BoardSquareState references to call their functions
  Map<String, BoardSquareState> boardSquareStates = {};
  String _selectedSquare;
  List _legalMovesOfSelectedPiece = [];
  List _moveHistorySAN = [];

  List get history => _moveHistorySAN;

  ///Called when BoardSquareStates are initialized. Provides a reference to each of them.
  void addBoardState(String squareName, State boardState) {
    boardSquareStates[squareName] = boardState;
  }

  ///Called whenever user taps on a board square (both empty and occupied)
  void _selectTile(String squareName) {
    ///Turn off last selected tile
    if (_selectedSquare != null) boardSquareStates[_selectedSquare].toggleSelection(false);

    ///Turn on the selected tile and show the available legal moves
    boardSquareStates[squareName].toggleSelection(true);
    _selectedSquare = squareName;
    removeOldLegalMoves();
    generateNewLegalMoves(squareName);
  }

  void removeOldLegalMoves() {
    _legalMovesOfSelectedPiece.forEach((entry) {
      boardSquareStates[entry['to']].toggleLegalMoveIndicator(false);
    });
  }

  void generateNewLegalMoves(String squareName) {
    _legalMovesOfSelectedPiece = _chess.moves({
      'square': squareName,
      'verbose': true
    });

    _legalMovesOfSelectedPiece.forEach((entry) {
      boardSquareStates[entry['to']].toggleLegalMoveIndicator(true);
    });
  }

  ///tappedSquare (i.e. e5) denotes the location of the square
  ///occupyingPiece is the name of the piece on that particular square
  void handleUserTap(String tappedSquare, String occupyingPiece) async {

    ///If there is no previously selected tile, then it is impossible to make a move.
    ///Select the tappedSquare if user taps his own piece, else do nothing
    if (_selectedSquare == null) {
      if (occupyingPiece?.substring(0, 1) == getPlayerTurn())
        _selectTile(tappedSquare);
    }
    ///If there is a previously selected tile, then movement is possible.
    ///Select the tappedSquare if user taps his own piece
    ///Make a move if the user taps his opponent's piece
    else {
      if (occupyingPiece?.substring(0, 1) == getPlayerTurn())
        _selectTile(tappedSquare);
      else
        makeMove(await isTargetLegalMove(tappedSquare));
    }
  }

  ///A san with value of null denotes that the move the user is trying to perform is not a legal move
  void makeMove(String san) {
    if (san == null) return;

    _chess.move(san);
    _moveHistorySAN.add(san);
    _cleanup();
    notifyListeners();
    _checkEndGame();
  }

  ///Removes old legal move indicators, previously selected tile and also reference to that tile
  void _cleanup() {
    removeOldLegalMoves();
    boardSquareStates[_selectedSquare].toggleSelection(false);
    _selectedSquare = null;
  }

  ///Undoes the last move
  void undoMove() {
    if (_moveHistorySAN.isNotEmpty) {
      _chess.undo_move();
      _moveHistorySAN.removeLast();
      notifyListeners();
    }
  }

  void restartBoard(){
    _chess.reset();
    _moveHistorySAN.clear();
    notifyListeners();
  }


  void _checkEndGame() async {
    if (_chess.in_checkmate) {
      bool a = await onCheckmate();
      if(a) {
        restartBoard();
      } else {
        undoMove();
      }
    } else if (_chess.in_check) {
      print('Checkhu');
    } else if (_chess.in_stalemate) {
      bool a = await onStalemate();
      if(a) {
        restartBoard();
      } else {
        undoMove();
      }
    }
  }

  String getPlayerTurn() {
    return _chess.turn.toString().toUpperCase();
  }

  String getPieceName(String square) {
    chesslib.Piece piece = _chess.get(square);
    return piece != null
        ? (piece.color.toString() + piece.type.name).toUpperCase()
        : null;
  }

  Future<String> isTargetLegalMove(String squareName) async {
    for (int i = 0; i < _legalMovesOfSelectedPiece.length; i++) {
      Map map = _legalMovesOfSelectedPiece[i];

      ///Move is legal
      if (map['to'] == squareName) {
        ///Determine if it is a promotion
        if ((map['flags'] as String).contains('p')) {
          String promotion = await onPromotion();
          Map promotionMap = _legalMovesOfSelectedPiece.singleWhere((map) =>
              map['to'] == squareName &&
              (map['san'] as String).contains(promotion));
          return promotionMap['san'];
        }
        return map['san'];
      }
    }
    return null;
  }

//  String _constructPromotionSan(String san, String promotion){
//    List<String> a = san.split("=");
//    if(a[1].length >1 ) a[1] = promotion + '+';
//    else a[1] = promotion;
//    return a[0] + '=' + a[1];
//  }

  static ChessBoardController of(BuildContext context) =>
      ScopedModel.of<ChessBoardController>(context);
}
