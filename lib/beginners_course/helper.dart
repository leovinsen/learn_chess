import 'package:flutter/material.dart';
import 'package:learn_chess/beginners_course/guide_page_template.dart';

VoidCallback createCallback(BuildContext context, String title, List<Widget> widgets){
  return (){
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => GuidePageTemplate(title: title , content: widgets,)
    ));
  };
}