import 'package:flutter/material.dart';

class BoardSetupGuide extends StatefulWidget {
  @override
  BoardSetupGuideState createState() {
    return new BoardSetupGuideState();
  }
}

class BoardSetupGuideState extends State<BoardSetupGuide> with SingleTickerProviderStateMixin{
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 9);

  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[

          Container(
            color: Colors.teal,
            child: Column(
              children: <Widget>[
                Flexible(
                  child: TabBarView(
                    controller: _tabController,
                    children: [0,1,2,3,4,5,6,7,8].map((int index) {
                      return Center(
                        child: Text(index.toString()),
                      );
                    }).toList()
                  ),
                ),

                PreferredSize(
                  preferredSize: const Size.fromHeight(48.0),
                  child: Theme(
                    data: Theme.of(context).copyWith(accentColor: Colors.white),
                    child: Container(
                      height: 48.0,
                      alignment: Alignment.center,
                      child: TabPageSelector(controller: _tabController),
                    ),
                  ),
                ),

              ],
            ),
          ),
          SizedBox(
            height: 80.0,
            width: double.infinity,
            child: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
