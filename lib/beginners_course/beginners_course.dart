import 'package:flutter/material.dart';
import 'package:learn_chess/beginners_course/board_setup.dart';
import 'package:learn_chess/beginners_course/checkmate_guide.dart';
import 'package:learn_chess/beginners_course/guide_page_template.dart';
import 'package:learn_chess/beginners_course/pieces_guide.dart';
import 'helper.dart';

class BeginnersCourse extends StatelessWidget {

  final List _enPassant = [
    "En Passant is French for 'in passing'",
    "If a pawn moves two squares on its initial move and lands to the side of an opponent pawn. By doing so the opponent's pawn cannot capture that pawn."
        "The en passant rule allows the opposing pawn to capture the pawn that had just moved two squares as if the pawn had just moved one square, thus allowing for a capture."
        "In doing so, the other pawn will seem to 'pass through' when capturing. "
        "However, this move must be performed immediately on the next turn, otherwise the option to capture will be lost.",
  ];

  List _data = [
    ["Board Setup", BoardSetupGuide()],
    ["Chess Pieces", PieceGuide()],
    ["How to Play", ConceptsGuide()],
  ];

  List<Widget> _enPassantContent;


  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    _enPassantContent = [
      pageWithCenter(_enPassant[0]),
      pageWithBoard(_enPassant[1], context)
    ];

    _data.add([
      "En Passant",
      GuidePageTemplate(title: "En Passant", content: _enPassantContent)
    ]);

    return ListView.separated(
      padding: const EdgeInsets.all(10.0),
      itemCount: _data.length,
      //crossAxisAlignment: CrossAxisAlignment.stretch,
      itemBuilder: (_, index) {
        return GestureDetector(
          child: ListTile(
            title: Text(
              _data[index][0],
              style: textTheme.headline,
            ),
          ),
          onTap: callbackGenerator(context, _data[index][1]),
        );
      },
      separatorBuilder: (_, index) {
        return Divider();
      },
    );

  }
  VoidCallback callbackGenerator(BuildContext context, Widget target) {
    return () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => target));
  }

}
