import 'package:flutter/material.dart';
import 'package:learn_chess/chess_board/board_square.dart';

class Board extends StatelessWidget {


  final double boardWidth;
  final bool enableMovement;

  const Board(this.boardWidth, this.enableMovement);

  Widget _buildBackground(){
    return Container(
      height: boardWidth,
      width: boardWidth,
      child: Image.asset(
        "images/chess_board.png",
      ),
    );
  }

  Widget _buildBoard(){
    return Container(
      height: boardWidth,
      width: boardWidth,
      child: Table(
        children: buildTiles(boardWidth / 8),
      ),
    );
  }

  ///Build the board square widgets
  List<TableRow> buildTiles(double squareWidth) {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: boardWidth,
      width: boardWidth,
      child: Stack(
        children: <Widget>[
          _buildBackground(),
          _buildBoard()
        ],
      ),
    );
  }
}
