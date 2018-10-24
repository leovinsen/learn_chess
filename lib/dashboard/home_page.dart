import 'package:flutter/material.dart';
import 'package:learn_chess/beginners_course/beginners_course.dart';
import 'package:learn_chess/chess_board/chess_board.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
       // color: Theme.of(context).,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildFirstCard(context),
            FlatButton(
              child: Text('play'),
              onPressed: () => openChessBoard(context),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFirstCard(BuildContext context){
    TextTheme textTheme = Theme.of(context).textTheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)) ,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text('New to Chess?', style: textTheme.headline),
                Text('Go to Beginner Section for a quick lesson!', style: textTheme.title,),
              ],
            ),
          ),

          GestureDetector(
            onTap: () => openBeginnersCourse(context),
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorLight,
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(10.0)
                  )
              ),
              child: Text('Try now!', style: textTheme.title,),
            ),
          )
        ],
      ),
    );
  }

  void openBeginnersCourse(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => BeginnersCourse()
    ));
  }

  void openChessBoard(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(),
          body: Center(
            child: ChessBoard(width: MediaQuery.of(context).size.width,),
          ),
        )
    ));
  }
}
