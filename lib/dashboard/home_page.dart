import 'package:flutter/material.dart';
import 'package:learn_chess/beginners_course/beginners_course.dart';
import 'package:learn_chess/chess_board/chess_board_widget.dart';

class HomePage extends StatefulWidget {

  @override
  HomePageState createState() {
    return new HomePageState();
  }

//  static openBeginnersCourse(BuildContext context){
//    Navigator.of(context).push(MaterialPageRoute(
//      builder: (_) => BeginnersCourse()
//    ));
//  }
//
//  static openChessBoard(BuildContext context){
//    Navigator.of(context).push(MaterialPageRoute(
//        builder: (_) => Scaffold(
//          appBar: AppBar(),
//          body: ChessBoardWidget(enableMovement: true, boardWidth: MediaQuery.of(context).size.width, showHUD: true,)
//        )
//    ));
//  }
}

class HomePageState extends State<HomePage> {
  final List data =[
    ["Beginners' Course", Icon(Icons.book)],
    ["Play Chess", Icon(Icons.play_arrow)],
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final drawer = Drawer(
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (_, index){
          return Container(
            color: index == _currentIndex ? Colors.grey.shade300 : null,
            child: ListTile(
              leading: data[index][1],
              title: Text(data[index][0]),
              onTap: (){
                Navigator.of(context).pop();
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          );
        },

      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(data[_currentIndex][0]),
      ),
      body: selectWidget(_currentIndex),
      drawer: drawer
    );
  }

  Widget selectWidget(int index){
    switch(index){
      case 0:
        return BeginnersCourse();
      case 1:
        return ChessBoardWidget(enableMovement: true, boardWidth: MediaQuery.of(context).size.width, showHUD: true,);
    }
  }

//  Widget _buildFirstCard(BuildContext context){
//    TextTheme textTheme = Theme.of(context).textTheme;
//
//    return Card(
//      clipBehavior: Clip.antiAlias,
//      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)) ,
//      child: Column(
//        crossAxisAlignment: CrossAxisAlignment.stretch,
//        children: <Widget>[
//          Padding(
//            padding: const EdgeInsets.all(12.0),
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.stretch,
//              children: <Widget>[
//                Text('New to Chess?', style: textTheme.headline),
//                Text('Go to Beginner Section for a quick lesson!', style: textTheme.title,),
//              ],
//            ),
//          ),
//
//          GestureDetector(
//            onTap: () => HomePage.openBeginnersCourse(context),
//            behavior: HitTestBehavior.opaque,
//            child: Container(
//              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
//              decoration: BoxDecoration(
//                  color: Theme.of(context).primaryColorLight,
//                  borderRadius: BorderRadius.vertical(
//                      bottom: Radius.circular(10.0)
//                  )
//              ),
//              child: Text('Try now!', style: textTheme.title,),
//            ),
//          )
//        ],
//      ),
//    );
//  }
}
