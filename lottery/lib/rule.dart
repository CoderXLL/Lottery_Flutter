import 'package:flutter/material.dart';

class RuleView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '抽奖规则',
            style: TextStyle(
              color: Color(0xFF333333),
              fontSize: 17.0,
            ),
          ),
        ),
        body: Image.asset(
          'assets/images/pic_rule@3x.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}