import 'package:flutter/material.dart';
import 'package:test1/ch18_stateManagement/subWidget1.dart';
import 'package:test1/ch18_stateManagement/subWidget2.dart';

import 'InheritedWidget.dart';

class ParentWidget extends StatefulWidget {
  const ParentWidget({super.key});

  @override
  State<ParentWidget> createState() => ParentWidgetState();
}

class ParentWidgetState extends State<ParentWidget> {
  int num = 0;
  bool heart = false;

  addNum() {
    num += 1;
    if (num > 9) {
      heart = true;
    }
    setState(() {});
  }

  resetNum() {
    num = 0;
    setState(() {});
  }

  heartTapped() {
    heart = !heart;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    MyInheritedWidget(Builder(
      builder: (context) => Container(),
    ));

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyInheritedWidget(
              SubWidget1(
                addNum: addNum,
                resetNum: resetNum,
              ),
            ),
            // 하위 위젯의 생성자 매개변수로 상태 데이터와 함수를 전달할 수 있다.
            // SubWidget1(
            //   addNum: addNum,
            //   resetNum: resetNum,
            // ),
            SubWidget2(
              parentHeartFunc: heartTapped,
            ),
          ],
        ),
      ),
    );
  }
}
