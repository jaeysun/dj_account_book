import 'package:acountbook/navigation/dj_bottom_navigation_bar.dart';
import 'package:acountbook/pages/charge/charge_page.dart';
import 'package:acountbook/pages/home/home_page.dart';
import 'package:acountbook/pages/user/user_center_page.dart';
import 'package:flutter/material.dart';

class DJBottomTabBarPage extends StatefulWidget {
  @override
  _DJBottomTabBarPageState createState() => _DJBottomTabBarPageState();
}

class _DJBottomTabBarPageState extends State<DJBottomTabBarPage> {
  // 当前选中的索引
  int currentIndex = 0;

  final PageController _pageController = PageController(
    initialPage: 0, // 默认选择第一个
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: <Widget>[
          DJHomePage(),
          DJChargeAccountPage(),
          DJUserCenterPage(),
        ],
      ),
      bottomNavigationBar: DJBottomNavigationBar(
        onTap: (index) {
        },
        defaultColor: Color(0xff8a8a8a),
        activeColor: Color(0xff50b4ed),
        centerItem: DJBottomNavigationBarOutItem(
          radius: 26.0,
          title: "记账",
          iconData: Icons.add_circle,
          selected: false,
        ),
        items: <Widget>[
          DJBottomNavigationBarItem(
            title: "首页",
            iconData: Icons.home,
            selected: true,
          ),
          DJBottomNavigationBarItem(
            title: "个人中心",
            iconData: Icons.person,
            selected: false,
          ),
        ],
        currentIndex: 0,
      ),
    );
  }
}
