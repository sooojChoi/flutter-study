import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test1/ch19_Provider/SubWidget1.dart';

void main() {
  runApp(const MyApp());
}

class Counter with ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    // 하위 위젯을 다시 빌드해주기 위함.
    notifyListeners();
  }
}

class Mode with ChangeNotifier {
  String mode = 'a';

  void changeMode() {
    if (mode == "a") {
      mode = 'b';
    } else {
      mode = 'a';
    }
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // MultiProvider로 여러 프로바이더 등록
        body: MultiProvider(
          providers: [
            Provider<int>.value(value: 10),
            Provider<String>.value(value: "provider test"),
            // create 속성으로 리턴 값을 상태 데이터로 이용할 수 있다.
            Provider<double>(create: (context) {
              double sum = 1.5;
              return sum * 3;
            }),
            // 상태 데이터 변했을 때 하위 위젯을 다시 빌드하기 위한 ChangeNotifierProvider
            ChangeNotifierProvider<Counter>.value(
              value: Counter(),
            ),
            ChangeNotifierProvider<Mode>.value(
              value: Mode(),
            ),
          ],
          child: const SubWidget1(),
        ),
      ),
    );
  }
}
