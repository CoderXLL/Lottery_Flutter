import 'package:flutter/material.dart';
import 'LotteryCircle.dart';
import 'dart:math';

void hideAwardAlert(context){
  Navigator.pop(context);
}

void showAwardAlert({@required BuildContext context,
@required LotteryItemModel itemModel}) {

  Navigator.of(context, rootNavigator: true).push(
    LotteryAwardAlert(itemModel: itemModel, popBlock: (){
      hideAwardAlert(context);
    })
  );
}

class LotteryAwardAlert extends TransitionRoute {

  LotteryAwardAlert({this.itemModel, this.popBlock});
  final LotteryItemModel itemModel;
  final VoidCallback popBlock;
  OverlayEntry _alertMaskView;

  @override
  void didChangePrevious(Route previousRoute) {
    // TODO: implement didChangePrevious
    super.didChangePrevious(previousRoute);
    changedInternalState();
  }

  @override
  void changedInternalState() {
    // TODO: implement changedInternalState
    super.changedInternalState();
    _alertMaskView.markNeedsBuild();
  }

  @override
  Iterable<OverlayEntry> createOverlayEntries() sync* {
    // TODO: implement createOverlayEntries
    yield _alertMaskView = OverlayEntry(builder: _builderMaskView);
    yield OverlayEntry(builder: _buildAlertView, maintainState: true);
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 100);

  @override
  bool get opaque => false;

  //蒙层
  Widget _builderMaskView(BuildContext context){
    //高斯模糊
    return IgnorePointer(
      ignoring: true,
      child: Opacity(
        opacity: 0.8,
        child: Container(
          color: Color(0xFF000000),
        ),
      ),
    );
  }

  //弹窗内容
  Widget _buildAlertView(BuildContext context) {
    //因为是新路由，必须使用Material包括，否则文字下面会出现双下划线。
    //颜色也要对应设置，这样才会透明
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.only(left: 73, right: 73, top: (MediaQuery.of(context).size.height - 362) * 0.5),
        height: 362,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '恭喜抽中『' + itemModel.titleName + '』',
              style: TextStyle(
                color: Color(0xFFFF713F),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 9),
              child: Text(
                '请填写收货地址',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            GiftContentView(giftImg: 'assets/images/' + itemModel.iconName + '.png',),
            Container(
              margin: EdgeInsets.only(top: 23),
              width: 222,
              height: 45,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22.5),
                child: GestureDetector(
                  onTap: popBlock,
                  child: Container(
                    alignment: Alignment.center,
                    color: Color(0XFFFF713F),
                    child: Text(
                      '领取奖励',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GiftContentView extends StatefulWidget {
  const GiftContentView({this.giftImg});
  final String giftImg;

  @override
  _GiftContentViewState createState() => new _GiftContentViewState();
}

class _GiftContentViewState extends State<GiftContentView> with SingleTickerProviderStateMixin {

  Animation<double> rotateValue;
  AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //控制类对象
    controller = new AnimationController(
        duration: const Duration(milliseconds: 4000),
        vsync: this);
    rotateValue = Tween<double>(
      begin: 0.0,
      end: pi * 2,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0,
          1.0,
          curve: Curves.linear,
        ),
      ),
    )
      ..addListener(() {
        setState(() {

        });
      });
    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 4),
      child: Stack(
        children: <Widget>[
          Transform.rotate(
            angle: rotateValue.value,
            child: Center(
              child: Image.asset(
                'assets/images/pic_light@3x.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
//          HeroGiftView(
//            isAlertStyle: true,
//            giftImg: widget.giftImg,
//          ),
          Container(
            margin: EdgeInsets.only(top: 50),
            child: Center(
              child: Image.asset(
                widget.giftImg,
                fit: BoxFit.fill,
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

class HeroGiftView extends StatelessWidget {
  const HeroGiftView({Key key, this.isAlertStyle, this.giftImg}) : super(key : key);
  final bool isAlertStyle;
  final String giftImg;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: isAlertStyle?EdgeInsets.only(top: 50) : EdgeInsets.all(0),
      width: isAlertStyle?100 : 60,
      height: isAlertStyle?100 : 60,
      child: Hero(
        tag: giftImg,
        child: Center(
          child: Image.asset(
            giftImg,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}