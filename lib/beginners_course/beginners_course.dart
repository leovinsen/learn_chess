import 'package:flutter/material.dart';
import 'package:learn_chess/beginners_course/board_setup.dart';
import 'package:learn_chess/beginners_course/checkmate_guide.dart';
import 'package:learn_chess/beginners_course/pieces_guide.dart';

class BeginnersCourse extends StatelessWidget {
  final List<String> titles = [
    'Setting up the board',
    'What are pieces?',
    'Winning the game',
  ];

  List<VoidCallback> callbacks = [];

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    callbacks.addAll([
      () => openBoardSetupGuide(context),
      () => openPiecesGuide(context),
      () => callbackGenerator(context, CheckmateGuide())
    ]);

    return Scaffold(
      appBar: AppBar(
        title: Text('Beginners Course'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.separated(
          itemCount: titles.length,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          itemBuilder: (_, index) {
            return GestureDetector(
              child: Text(
                titles[index],
                style: textTheme.headline,
              ),
              onTap: callbacks[index],
            );
          },
          separatorBuilder: (_, index) {
            return Divider();
          },
        ),
      ),
    );
  }

  void openBoardSetupGuide(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => BoardSetupGuide()));
  }

  void openPiecesGuide(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => PieceGuide()));
  }

  void callbackGenerator(BuildContext context, Widget target) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => target));
  }

  List headlines = ['1. Set up the board', '2. How to '];
}
