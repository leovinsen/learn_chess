import 'package:flutter/material.dart';
import 'package:learn_chess/beginners_course/guide_page_template.dart';
import 'package:learn_chess/chess_board/chess_board_widget.dart';
import 'styling.dart' show textTheme;

VoidCallback createCallback(BuildContext context, Widget pushedWidget){
  return (){
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => pushedWidget
    ));
  };
}

GuidePageTemplate constructPage(String title, List<Widget> widget){
  return GuidePageTemplate(title: title , content: widget);
}

Widget pageWithCenter(String text){
  return Center(
    child: Text(text, style: textTheme.title, textAlign: TextAlign.justify,),
  );
}

Widget pageWithBoard(String text, BuildContext context, [ String fen]){
  return Center(
    child: Column(
      children: <Widget>[
        ChessBoardWidget(showHUD: false, enableMovement: false, boardWidth: MediaQuery.of(context).size
          .width*0.7,),
        Text(text, style: textTheme.title, textAlign: TextAlign.justify,)
      ],
    ),
  );
}
