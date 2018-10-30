import 'package:flutter/material.dart';
import 'package:learn_chess/dashboard/home_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        textTheme: buildTextTheme(Theme.of(context).textTheme),
        primarySwatch: Colors.grey,
        primaryColor: Colors.grey.shade600,
        primaryColorLight: Colors.grey.shade300
      ),
      home: new HomePage(),
    );
  }

  TextTheme buildTextTheme(TextTheme base){

    return base.copyWith(
      headline: base.headline.copyWith(
        fontWeight: FontWeight.w500,
      ),
      title: base.title.copyWith(
          fontSize: 18.0
      ),
      caption: base.caption.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 14.0,
      ),
    );
//        .apply(
//      fontFamily: 'Rubik',
//      displayColor: kShrineBrown900,
//      bodyColor: kShrineBrown900,
//    );
  }

}