import 'package:flutter/material.dart';
import 'dart:async';

const double _ITEM_HEIGHT = 32.0;

class ListModel {
  const ListModel({this.userIcon, this.desc});
  final String userIcon;
  final String desc;
}

class ScrollListView extends StatefulWidget {

  @override
  ScrollListViewState createState() => new ScrollListViewState();
}

class ScrollListViewState extends State<ScrollListView> {

  List<ListModel> _itemLists;
  ScrollController _scrollController;
  int _currentIndex = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _itemLists = <ListModel>[
      ListModel(
        userIcon: 'assets/images/userHead@3x.png',
        desc: '小叮当抽中了悠悠球1',
      ),
      ListModel(
        userIcon: 'assets/images/userHead@3x.png',
        desc: '小叮当抽中了悠悠球2',
      ),
      ListModel(
        userIcon: 'assets/images/userHead@3x.png',
        desc: '小叮当抽中了悠悠球3',
      ),
      ListModel(
        userIcon: 'assets/images/userHead@3x.png',
        desc: '小叮当抽中了悠悠球4',
      ),
      ListModel(
        userIcon: 'assets/images/userHead@3x.png',
        desc: '小叮当抽中了悠悠球5',
      ),
    ];
    _scrollController = ScrollController(initialScrollOffset: 0);
    Timer.periodic(const Duration(seconds: 3), (Timer timer){
      if (_currentIndex == -1) {
        _currentIndex = 1;
      } else {
        _currentIndex ++;
        if (_currentIndex >= _itemLists.length) {
          _currentIndex = 0;
        }
      }
      if (_currentIndex > 0) {
        _scrollController.animateTo(
            _currentIndex * _ITEM_HEIGHT,
            duration: Duration(seconds: 1),
            curve: Curves.ease
        );
      } else if (_currentIndex == 0) {
        _scrollController.jumpTo(0);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return IgnorePointer(
      ignoring: true,
      child: ListView(
        primary: false,
        scrollDirection: Axis.vertical,
        controller: _scrollController,
        shrinkWrap: true,
        children: _itemLists.map((ListModel item) {
          return Container(
            height: _ITEM_HEIGHT,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 22,
                  height: 22,
                  margin: EdgeInsets.only(left: 16,),
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                      item.userIcon,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 12.0,),
                  child: Text(
                    item.desc,
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
            /**
                child: ListTile(
                leading: CircleAvatar(
                backgroundImage: AssetImage(
                item.userIcon,
                ),
                ),
                title: Text(
                item.desc,
                style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 13,
                fontWeight: FontWeight.normal,
                ),
                ),
                ),
             */
          );
        }).toList(),
      ),
    );
  }
}