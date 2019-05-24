import 'package:flutter/material.dart';
import 'package:gslflutter/TestPage.dart';

class TopTabNewsPage extends StatefulWidget {
  final TabController tabController;

  TopTabNewsPage({Key key, @required this.tabController}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TopTabNewsPageState();
  }
}

class _TopTabNewsPageState extends State<TopTabNewsPage> {
  @override
  Widget build(BuildContext context) {
    var viewList = [
      TestPage(title: '本会要闻'),
      TestPage(title: '政策宣传'),
      TestPage(title: '会务盛况'),
      TestPage(title: '活动风采'),
    ];
    return TabBarView(
      children: viewList,
      controller: widget.tabController,
    );
  }
}
