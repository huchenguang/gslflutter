import 'package:flutter/material.dart';

class SearchTextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.only(top: 8, bottom: 8, left: 11),
      margin: EdgeInsets.only(left: 11, right: 11),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(3.0)),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 8),
            child: Image.asset(
              "assets/images/icon_search.png",
              width: 12,
              height: 20,
            ),
          ),
          Text(
            '搜索关键字',
            style: TextStyle(fontSize: 12, color: Colors.grey[500]),
          )
        ],
      ),
    );
  }
}
