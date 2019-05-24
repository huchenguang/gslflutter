import 'package:flutter/material.dart';
import 'package:gslflutter/TestPage.dart';
import 'package:gslflutter/news/TabNewsPage.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}

class _Item {
  String name, activeIcon, normalIcon;

  _Item(this.name, this.activeIcon, this.normalIcon);
}

class MainPageState extends State<MainPage> {
  List<Widget> pages;
  final itemNames = [
    _Item('资讯', 'assets/images/nav_news_pressed.png',
        'assets/images/nav_news_normal.png'),
    _Item('通知', 'assets/images/nav_notify_pressed.png',
        'assets/images/nav_notify_normal.png'),
    _Item('我的', 'assets/images/nav_mine_pressed.png',
        'assets/images/nav_mine_normal.png'),
  ];
  List<BottomNavigationBarItem> itemList;
  int _selectIndex = 0;

  @override
  void initState() {
    super.initState();
    if (pages == null) {
      pages = [
        TabNewsPage(),
        TestPage(title: '通知'),
        TestPage(title: '我的'),
      ];
    }

    if (itemList == null) {
      itemList = itemNames
          .map((item) => BottomNavigationBarItem(
              icon: Image.asset(
                item.normalIcon,
                width: 20.0,
                height: 20.0,
              ),
              title: Container(
                margin: EdgeInsets.only(top: 3),
                child: Text(
                  item.name,
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
              activeIcon: Image.asset(
                item.activeIcon,
                width: 20.0,
                height: 20.0,
              )))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        //重叠组件
        children: <Widget>[
          _getPagesWidget(0),
          _getPagesWidget(1),
          _getPagesWidget(2),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: itemList,
        onTap: (int index) {
          setState(() {
            _selectIndex = index;
          });
        },
        selectedFontSize: 12.0,
        iconSize: 25,
        currentIndex: _selectIndex,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  _getPagesWidget(int index) {
    return Offstage(
      //可显示与隐藏的布局
      offstage: _selectIndex != index,
      child: TickerMode(
        enabled: _selectIndex == index,
        child: pages[index],
      ),
    );
  }
}
