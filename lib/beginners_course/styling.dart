import 'package:flutter/material.dart';

TextTheme textTheme = TextTheme(
    headline: TextStyle(
      fontSize: 23.0,
      fontWeight: FontWeight.w500,
    ),
    title: TextStyle(
        fontSize: 16.0
    ),
    caption: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14.0,
    )
).apply(
    bodyColor: Colors.white
);

double pageHorizontalPadding = 30.0;