import 'package:flutter/material.dart';
import 'package:learn_chess/beginners_course/board_setup.dart';

class BeginnersCourse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Beginners Course'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            GestureDetector(
              onTap: ()=> openBoardSetupGuide(context),
              child: Text('1. How to Move pieces', style: textTheme.headline,),
            )
          ],

        ),
      ),
    );
  }

  void openBoardSetupGuide(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => BoardSetupGuide()
    ));
  }
}
