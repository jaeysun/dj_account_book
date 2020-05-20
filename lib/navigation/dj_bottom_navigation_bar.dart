import 'dart:math';

import 'package:acountbook/utils/dj_constants.dart';
import 'package:flutter/material.dart';

class DJBottomNavigationBar extends StatefulWidget {
  final void Function(int index) onTap;
  final Widget centerItem;
  final List<Widget> items;
  final Color defaultColor;
  final Color activeColor;
  final int currentIndex;
  const DJBottomNavigationBar({
    Key key,
    this.onTap,
    this.centerItem,
    this.items,
    this.defaultColor,
    this.activeColor,
    this.currentIndex,
  }) : super(key: key);

  @override
  _DJBottomNavigationBarState createState() => _DJBottomNavigationBarState();
}

class _DJBottomNavigationBarState extends State<DJBottomNavigationBar> {

  @override
  Widget build(BuildContext context) {

    // 底部偏移，适配iPhoneXxi系列
    final double additionalBottomPadding =
        MediaQuery.of(context).padding.bottom;

    // items个数必须为偶数个
    if(widget.items.length%2 != 0) return null;
    List<Widget> _totalItems = [];
    for (int i = 0; i < widget.items.length; i++) {
      if (i == widget.items.length / 2) {
        _totalItems.add(Expanded(child: widget.centerItem));
      }
      _totalItems.add(Expanded(child: widget.items[i]));
    }
    
    return Semantics(
      explicitChildNodes: true,
      child: Material(
        color: Colors.white,
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minHeight: kBottomNavigationBarHeight + additionalBottomPadding),
          child: CustomPaint(
            painter: CustomPaintBottomBar(),
            child: Material(
              type: MaterialType.transparency,
              child: Padding(
                padding: EdgeInsets.only(bottom: additionalBottomPadding),
                child: MediaQuery.removePadding(
                  context: context,
                  removeBottom: true,
                  child: Container(
                    height: kBottomNavigationBarHeight,
                    child: Flex(
                      direction: Axis.horizontal,
                      children: _totalItems,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DJBottomNavigationBarOutItem extends StatefulWidget {
  final double radius;
  final String title;
  final IconData iconData;
  final bool selected;
  const DJBottomNavigationBarOutItem(
      {Key key, this.title, this.iconData, this.selected, this.radius})
      : super(key: key);
  @override
  _DJBottomNavigationBarOutItemState createState() =>
      _DJBottomNavigationBarOutItemState();
}

class _DJBottomNavigationBarOutItemState
    extends State<DJBottomNavigationBarOutItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.cyan,
      child: Stack(
        alignment: Alignment.center,
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned(
            bottom: 5.0,
            child: Column(children: <Widget>[
              Icon(
                widget.iconData,
                size: widget.radius * 2,
                color: Colors.red,
              ),
              Text(
                widget.title,
                style: TextStyle(fontSize: 13.0, color: Colors.grey),
              )
            ]),
          ),
        ],
      ),
    );
  }
}

class DJBottomNavigationBarItem extends StatefulWidget {
  final String title;
  final IconData iconData;
  final bool selected;
  final VoidCallback onPressed;
  const DJBottomNavigationBarItem(
      {Key key, this.title, this.iconData, this.selected, this.onPressed})
      : super(key: key);
  @override
  _DJBottomNavigationBarItemState createState() =>
      _DJBottomNavigationBarItemState();
}

class _DJBottomNavigationBarItemState extends State<DJBottomNavigationBarItem> {
  final Color activeColor = Colors.lightBlue;
  final Color defaultColor = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: double.infinity,
      ),
      child: Container(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: 5.0,
            top: 6.0,
          ),
          child: Container(
            child: Column(
              children: <Widget>[
                Icon(
                  widget.iconData,
                  size: 26.0,
                  color: widget.selected ? activeColor : defaultColor,
                ),
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 13.0,
                    color: widget.selected ? activeColor : defaultColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomPaintBottomBar extends CustomPainter {
  double radius = 27.0 / cos(DJ_PI / 12);
  //绘制流程
  @override
  void paint(Canvas canvas, Size size) {
    Paint p = new Paint();
    p.color = Colors.white; // 画笔颜色
    p.isAntiAlias = true; // 是否抗锯齿
    p.style = PaintingStyle.fill; //画笔样式:填充
    p.strokeWidth = 1.0;
    Path path = new Path();
    path.moveTo(0.0, 0.0);
    Rect rect = Rect.fromCircle(
        center: Offset(size.width * 0.5, 0 + radius * sin(DJ_PI / 12)),
        radius: radius);
    path.arcTo(rect, DJ_PI * 13 / 12, DJ_PI * 10 / 12, false);
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.lineTo(0.0, 0.0);
    canvas.drawPath(path, p);
  }

  // 刷新布局的时候告诉flutter 是否需要重绘
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
