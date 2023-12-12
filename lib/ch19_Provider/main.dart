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

class ProxyTest with ChangeNotifier {
  int sum = 0;

  ProxyTest(this.sum);

  void changeSum(value) {
    sum = value;
    notifyListeners();
  }
}

class Mode with ChangeNotifier {
  String mode = 'a';
  String selectorTest = 'hehe';

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
            // 다른 상태값을 참조하여 상태를 리턴하는 ProxyProvider
            ProxyProvider<Counter, ProxyTest>(
              update: (context, value, previous) {
                // 상탯값만 갱신
                if (previous != null) {
                  previous.sum = value._count + 100;
                  return previous;
                }
                // 새로운 객체 생성
                else {
                  return ProxyTest(value._count + 100);
                }
              },
            ),
            // Future 데이터로 상태 등록
            FutureProvider<String>(
                create: (context) =>
                    Future.delayed(const Duration(seconds: 4), () => "second"),
                initialData: "first"),
          ],
          child: const SubWidget1(),
        ),
      ),
    );
  }
}
