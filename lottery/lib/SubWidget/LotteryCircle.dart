import 'package:flutter/material.dart';
import 'dart:math';
import 'LotteryAwardAlert.dart';

typedef void OnTapClickBlock();

class LotteryCirclePan extends StatefulWidget {

  LotteryCirclePan({this.tapClickBlock});
  final OnTapClickBlock tapClickBlock;
  @override
  _LotteryCirclePanState createState() => new _LotteryCirclePanState();
}


class LotteryItemModel {

  const LotteryItemModel({this.titleName, this.iconName});
  final String titleName;
  final String iconName;
}

class _LotteryCirclePanState extends State<LotteryCirclePan> with SingleTickerProviderStateMixin {

  final List<LotteryItemModel>_lotteryList = <LotteryItemModel>[
    LotteryItemModel(
      titleName: '10颗星星',
      iconName: 'item_stars@3x',
    ),
    LotteryItemModel(
      titleName: '悠悠球',
      iconName: 'item_ball@3x',
    ),
    LotteryItemModel(
      titleName: '100g蜂蜜',
      iconName: 'item_honeys@3x',
    ),
    LotteryItemModel(
      titleName: '谢谢参与',
      iconName: 'item_thanks@3x',
    ),
    LotteryItemModel(
      titleName: '10g蜂蜜',
      iconName: 'item_honey@3x',
    ),
    LotteryItemModel(
      titleName: '油画棒',
      iconName: 'item_draw@3x',
    ),
    LotteryItemModel(
      titleName: '2颗星星',
      iconName: 'item_star@3x',
    ),
    LotteryItemModel(
      titleName: '字母笔',
      iconName: 'item_wordPen@3x',
    ),
  ];

  List<Widget>getItemWidgets(){

    List<Widget>_itemWidgets = <Widget>[];
    for (int i = 0; i < _lotteryList.length; i++) {

      LotteryItemModel itemModel = _lotteryList[i];
      Widget item = MyTransitionItem(
        angle: pi / 180.0 * (i * 1.0 / _lotteryList.length) * 360.0,
        child: Transform.rotate(
          angle: pi / 180.0 * (i * 1.0 / _lotteryList.length) * 360.0 + 90 * pi / 180.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                itemModel.titleName,
                style: TextStyle(
                  color: Color(0xFF974500),
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
//              HeroGiftView(
//                isAlertStyle: false,
//                giftImg: 'assets/images/' + itemModel.iconName + '.png',
//              ),
              Container(
                width: 60,
                height: 60,
                child: Image.asset(
                  'assets/images/' + itemModel.iconName + '.png',
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ),
      );
      _itemWidgets.add(item);
    }
    return _itemWidgets;
  }

  Animation<double> tween;
  AnimationController controller;
  bool _isAnimating = false;
  var _statusListener;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //控制类对象
    controller = new AnimationController(
        duration: const Duration(milliseconds: 5000),
        vsync: this);
  }

  void _gestureTap() {
    int rewardIndex = Random().nextInt(8);
    if (widget.tapClickBlock != null) {
      widget.tapClickBlock();
    }
    _statusListener = (AnimationStatus status) {
      print('$status');
      if (status == AnimationStatus.completed) {
        _isAnimating = false;
        showAwardAlert(context: context, itemModel: _lotteryList[rewardIndex]);
        tween.removeStatusListener(_statusListener);
      }
    };

    double rewardAngle = pi / 180.0 *
        (270 - (rewardIndex * 1.0 / _lotteryList.length) * 360.0);
    //补间动画
    tween = Tween<double>(
      begin: 0.0,
      end: pi * 2 * 3 + rewardAngle,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0,
          1.0,
          curve: Curves.easeOut,
        ),
      ),
    )
      ..addListener(() {
        setState(() {

        });
      })
      ..addStatusListener(_statusListener);
    controller.reset();
    controller.forward();
    _isAnimating = true;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
//      transform: Matrix4.identity()..rotateZ(tween.value),
      padding: EdgeInsets.only(top: 31, left: 18, right: 18),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Transform.rotate(
            angle: tween != null?tween.value : 0,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                //转盘背景
                Image.asset(
                  'assets/images/pic_circlePan@3x.png',
                ),
                //转盘奖励内容
                Stack(
                  children: getItemWidgets(),
                ),
              ],
            ),
          ),
          //转盘中间开启按钮
          GestureDetector(
            onTap: _isAnimating?null:_gestureTap,
            child: Container(
              width: 94,
              height: 94,
              child: Stack(
                children: <Widget>[
                  Image.asset(
                    'assets/images/startLottery@3x.png',
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 14),
                        child: Text(
                          '开始抽奖',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 14,),
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              child: Container(
                                width: 46,
                                height: 20,
                                color: Colors.red,
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        '-6',
                                        style: TextStyle(
                                          color: Color(0xFFFFFFFF),
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Image.asset(
                                        'assets/images/item_star@3x.png',
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }
}

class MyTransitionItem extends StatelessWidget {

  MyTransitionItem({this.angle, this.child});
  final double angle;
  final Widget child;

  final double radius = 90.0;
  @override
  Widget build(BuildContext context) {
    final x = radius * cos(angle);
    final y = radius * sin(angle);
    return Transform(
      transform: Matrix4.translationValues(x, y, 0.0),
      child: child,
    );
  }
}