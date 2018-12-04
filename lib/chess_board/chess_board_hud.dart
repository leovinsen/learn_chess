import 'package:flutter/material.dart';

///Heads-up Display that contains buttons such as undo and redo
///and also displays the move history
class ChessHUD extends StatelessWidget {
  ///Function is called when Undo button is pressed
  final Function undoMove;

  ///List of moves in the current game
  List history;

  ChessHUD({@required this.undoMove, @required this.history})
      : assert(undoMove != null),
        assert(history != null);

  ///Formats the list of moves into chess SAN-style format.
  ///The format is as follows:
  /// x. WW BB
  /// where x is the number of turn
  /// WW is White's move
  /// BB is Black's move
  String _buildPrettyHistory(){

    ///Use StringBuffer for better performance
    var sb = StringBuffer();
    int moveNo = 0;
    for(int i =0; i<history.length; i++){
      ///Even indices are white's move
      ///Odd indices are black's move
      if(i % 2 == 0){
        moveNo++;
        sb.write("$moveNo. ${history[i]} ");
      } else {
        sb.write(history[i] + "   ");
      }
    }
    return sb.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: IconButton(
                icon: Icon(Icons.keyboard_arrow_left),
                onPressed: () => undoMove(),
                tooltip: 'Undo',
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                  icon: Icon(Icons.keyboard_arrow_right),
                  onPressed: () => null),
            )
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Text(_buildPrettyHistory(), maxLines: 20, textAlign: TextAlign.start,),
        )
      ],
    );
  }
}
