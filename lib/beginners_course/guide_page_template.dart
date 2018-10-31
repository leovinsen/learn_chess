import 'package:flutter/material.dart';
import 'styling.dart';

class GuidePageTemplate extends StatefulWidget {
  final String title;
  final List<Widget> content;

  GuidePageTemplate({@required this.title, @required this.content})
      : assert(title != null),
        assert (content != null);

  @override
  GuidePageTemplateState createState() {
    return new GuidePageTemplateState();
  }
}

class GuidePageTemplateState extends State<GuidePageTemplate> {

  final PageController _controller = PageController();

  int _currentIndex = 0;
  double _hPadding = 30.0;
  double _topPadding = 90.0;
  double _bottomPadding = 30.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          page(),
          appBar()
        ],
      ),
    );
  }

  Widget page(){
    final backgroundColor = BoxDecoration(
        gradient: new LinearGradient(
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomRight,
            colors: [
              const Color(0xFF3C3B3F),
              const Color(0xFF605C3C),
            ]
        )
    );

    return Container(
      decoration: backgroundColor,
      child: Column(
        children: <Widget>[
          pageContent(),
          pageIndicator(context),
        ],
      ),
    );
  }

  Widget pageContent(){
    return Flexible(
      child: Padding(
          padding: EdgeInsets.only(top: _topPadding, left: _hPadding, right: _hPadding, bottom: _bottomPadding),
          child: PageView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.content.length,
            controller: _controller,
            itemBuilder: (_, index) {
              return widget.content[index];
            },
          )
      ),
    );
  }

  Widget pageIndicator(BuildContext context){
    return PreferredSize(
      preferredSize: const Size.fromHeight(20.0),
      child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.keyboard_arrow_left, color: Colors.white,),
              onPressed: () => previousPage(),
            ),
            Expanded(child: Center(
                child: Text('${_currentIndex+1}/${widget.content.length}',
                  style: textTheme.title,)
            )
            ),
            IconButton(
              icon: Icon(Icons.keyboard_arrow_right,color: Colors.white,),
              onPressed: () => nextPage(),
            ),

          ]
      ),
    );
  }

  Widget appBar(){
    return SizedBox(
      height: 80.0,
      width: double.infinity,
      child: AppBar(
        centerTitle: true,
        title: Text(widget.title, style: textTheme.headline,),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
    );
  }

  void previousPage(){
    print('prev');
    if(_currentIndex >0) setState(() {
      _currentIndex -= 1;
      _controller.jumpToPage(_currentIndex);
    });
  }

  void nextPage(){
    if(_currentIndex <widget.content.length - 1) setState(() {
      _currentIndex += 1;
      _controller.jumpToPage(_currentIndex);
    });
  }
}

