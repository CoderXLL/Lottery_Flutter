import 'package:flutter/material.dart';
import 'SubWidget/LotteryCircle.dart';

void main() => runApp(FlutterView());

class FlutterView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFFFFFFFF),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              '星星抽奖',
              style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 17,
                  fontWeight: FontWeight.normal
              ),
            ),
          ),
        ),
        body: LotteryView(),
      ),
    );
  }
}

class LotteryView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Stack(
        children: <Widget>[
          ConstrainedBox(
            constraints: BoxConstraints.expand(),
            child: Image.asset(
              'assets/images/bg_raffle@3x.png',
              fit: BoxFit.fill,
              filterQuality: FilterQuality.high,
            ),
          ),
          Container(
            child: LotteryColumn(),
          ),
        ],
      ),
    );
  }
}


class LotteryColumn extends StatefulWidget {

  @override
  _LotteryColumnState createState() => new _LotteryColumnState();
}

class _LotteryColumnState extends State<LotteryColumn> {

  int _lotteryCount = 5;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 11),
          child: LotteryFirstView(),
        ),
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5),
              child: LotteryCirclePan(
                tapClickBlock: () {
                  setState(() {
                    _lotteryCount--;
                  });
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 305),
              width: 32,
              height: 44,
              child: Image.asset(
                'assets/images/pic_sel@3x.png',
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.only(top: 38),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 31,
                height: 31,
                child: Image.asset(
                    'assets/images/pic_gft@3x.png'
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 7),
                child: Text(
                  '今天还剩 ' + '$_lotteryCount' + ' 次抽奖机会',
                  style: TextStyle(
                    color: Color(0xFFB25200),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class LotteryFirstView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //第一行
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 32,
              width: 210,
              child: Stack(
                children: <Widget>[
                  Image.asset(
                    'assets/images/bg_user message@3x.png',
                     fit: BoxFit.fill,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 22,
                        height: 22,
                        margin: EdgeInsets.only(left: 16, top: 5),
                        child: CircleAvatar(
                          backgroundImage: AssetImage(
                            'assets/images/userHead@3x.png'
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 12.0, top: 5),
                        child: Text(
                          '小叮当抽中了悠悠球',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: 72,
              height: 28,
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width - 210 - 72),
              child: Stack(
                children: <Widget>[
                  Image.asset(
                    'assets/images/bg_regular@3x.png',
                    fit: BoxFit.fill,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 13),
                    child: Center(
                      child: Text(
                        '游戏规则',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        //第二行
        Container(
          height: 59,
          margin: EdgeInsets.only(top: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              MyStarView(),
              Container(
                width: 72,
                height: 28,
                margin: EdgeInsets.only(left: MediaQuery.of(context).size.width - 167 - 72, bottom: 25),
                child: Stack(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/bg_regular@3x.png',
                      fit: BoxFit.fill,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 13,),
                      child: Center(
                        child: Text(
                          '实物奖品',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

      ],
    );
  }
}

class MyStarView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 167,
      height: 39,
      margin: EdgeInsets.only(top: 14),
      child: Stack(
        children: <Widget>[
          Image.asset(
            'assets/images/bg_my star@3x.png',
            fit: BoxFit.fill,
          ),
          Container(
            margin: EdgeInsets.only(left: 13, top: 8.2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  '我的星星',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  width: 22,
                  height: 22,
                  margin: EdgeInsets.only(left: 15),
                  child: Image.asset(
                    'assets/images/picStar@3x.png',
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 11),
                  child: Text(
                    '42',
                    style: TextStyle(
                      color: Color(0xFFFFEAB0),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}