//import 'package:flutter/material.dart';
//import 'package:learn_chess/chess_board/board_square.dart';
//import 'package:learn_chess/chess_board/chess_board_controller.dart';
//import 'package:scoped_model/scoped_model.dart';
//import 'package:flutter/foundation.dart';
//
//class ChessBoard extends StatefulWidget {
//  final double width;
//  final bool enableMovement;
//  final String fen;
//
//  const ChessBoard(
//      {@required this.width, @required this.enableMovement, this.fen})
//      : assert (enableMovement != null),
//        assert (width != null);
//
//  @override
//  _ChessBoardState createState() => _ChessBoardState();
//}
//
//class _ChessBoardState extends State<ChessBoard> {
//   double width;
//
//  @override
//  void initState() {
//    super.initState();
//    width = widget.width;
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    final boardBackground = Container(
//      height: width,
//      width: width,
//      child: Image.asset(
//        "images/chess_board.png",
//      ),
//    );
//    final boardSquares = Container(
//      height: width,
//      width: width,
//      child: Table(
//        children: buildBoard(width / 8),
//        // height: width,
//        // width: width,
//        //child: buildChessBoard(),
//      ),
//    );
//
//    return Container(
//        height: width,
//        width: width,
//        child: Stack(
//          children: <Widget>[
//            boardBackground,
//            boardSquares
//          ],
//        ),
//    );
////    final model = ChessBoardController(widget.fen);
//
////    return ScopedModel<ChessBoardController>(
////      model: model,
////      child: Container(
////        height: width,
////        width: width,
////        child: Column(
////          crossAxisAlignment: CrossAxisAlignment.stretch,
////          children: <Widget>[
////            Stack(
////              children: <Widget>[
////                boardBackground,
////                boardSquares
////              ],
////            ),
////
////          ],
////        ),
////      ),
////    );
//  }
//
//  List<TableRow> buildBoard(double squareWidth) {
//    //from white perspective
//    var squareList = [
//      [
//        "a8",
//        "b8",
//        "c8",
//        "d8",
//        "e8",
//        "f8",
//        "g8",
//        "h8",
//      ],
//      [
//        "a7",
//        "b7",
//        "c7",
//        "d7",
//        "e7",
//        "f7",
//        "g7",
//        "h7",
//      ],
//      [
//        "a6",
//        "b6",
//        "c6",
//        "d6",
//        "e6",
//        "f6",
//        "g6",
//        "h6",
//      ],
//      [
//        "a5",
//        "b5",
//        "c5",
//        "d5",
//        "e5",
//        "f5",
//        "g5",
//        "h5",
//      ],
//      [
//        "a4",
//        "b4",
//        "c4",
//        "d4",
//        "e4",
//        "f4",
//        "g4",
//        "h4",
//      ],
//      [
//        "a3",
//        "b3",
//        "c3",
//        "d3",
//        "e3",
//        "f3",
//        "g3",
//        "h3",
//      ],
//      [
//        "a2",
//        "b2",
//        "c2",
//        "d2",
//        "e2",
//        "f2",
//        "g2",
//        "h2",
//      ],
//      [
//        "a1",
//        "b1",
//        "c1",
//        "d1",
//        "e1",
//        "f1",
//        "g1",
//        "h1",
//      ],
//    ];
//
//    return squareList.map((row) {
//      return TableRow(
//          children: row.map((square) {
//        return BoardSquare(squareName: square, squareWidth: squareWidth, enableMovement: widget.enableMovement,);
//      }).toList());
//    }).toList();
//  }
//}
