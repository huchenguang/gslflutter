import 'package:flutter/material.dart';
import 'package:gslflutter/news/TopTabNewsPage.dart';
import 'package:gslflutter/utils/ColorConstant.dart';
import 'package:gslflutter/widget/SearchTextWidget.dart';
import 'dart:math' as math;

var titleList = ['本会要闻', '政策宣传', '会务盛况', '活动风采'];
List<Widget> tabList;
TabController _tabController;

class TabNewsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TabNewsPageState();
  }
}

class _TabNewsPageState extends State<TabNewsPage>
    with SingleTickerProviderStateMixin {
  var tabBar;

  @override
  void initState() {
    super.initState();
    tabList = titleList
        .map((item) => Text(
              '$item',
              style: TextStyle(fontSize: 15),
            ))
        .toList();
    _tabController = TabController(length: tabList.length, vsync: this);
    tabBar = NewsTabBarPage();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
          //能很好的解决刘海，不规则屏幕的显示问题。
          child: DefaultTabController(
              length: titleList.length, child: _getNestedScrollView(tabBar))),
    );
  }

  _getNestedScrollView(Widget tabBar) {
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(4.0),
                child: SearchTextWidget(),
              ),
            ),
            SliverPersistentHeader(
                pinned: true,
                floating: true,
                delegate: _SliverAppBarDelegate(
                    maxHeight: 49.0,
                    minHeight: 49.0,
                    child: Container(
                      color: Colors.white,
                      child: tabBar,
                    )))
          ];
        },
        body: TopTabNewsPage(
          tabController: _tabController,
        ));
  }
}

class NewsTabBarPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewsTabBarPageState();
  }
}

class _NewsTabBarPageState extends State<NewsTabBarPage> {
  Color selectColor, unselectedColor;
  TextStyle selectStyle, unselectedStyle;

  @override
  void initState() {
    super.initState();
    selectColor = Color(ColorConstant.color_blue);
    unselectedColor = Color(ColorConstant.color_33);
    selectStyle = TextStyle(fontSize: 18, color: selectColor);
    unselectedStyle = TextStyle(fontSize: 18, color: selectColor);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: TabBar(
      tabs: tabList,
      isScrollable: true,
      controller: _tabController,
      indicatorColor: selectColor,
      labelColor: selectColor,
      labelStyle: selectStyle,
      unselectedLabelColor: unselectedColor,
      unselectedLabelStyle: unselectedStyle,
      indicatorSize: TabBarIndicatorSize.label,
    ));
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverAppBarDelegate(
      {@required this.minHeight,
      @required this.maxHeight,
      @required this.child});

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max((minHeight ?? kToolbarHeight), minExtent);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return child;
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
