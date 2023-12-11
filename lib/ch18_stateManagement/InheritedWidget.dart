import 'package:flutter/material.dart';

class MyInheritedWidget extends InheritedWidget {
  int count = 100;

  MyInheritedWidget(child, {super.key}) : super(child: child);

  increment() {
    count++;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static MyInheritedWidget? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>();
}
