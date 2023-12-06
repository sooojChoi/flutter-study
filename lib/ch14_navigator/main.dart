import 'package:flutter/material.dart';
import 'package:test1/ch14_navigator/screens/NavigationBarExample.dart';
import 'package:test1/ch14_navigator/screens/fourthScreen.dart';
import 'package:test1/ch14_navigator/screens/homeScreen.dart';
import 'package:test1/ch14_navigator/screens/secondScreen.dart';
import 'package:test1/ch14_navigator/screens/thirdScreen.dart';

void main() {
  runApp(const MyNavigatorApp());
}

class MyNavigatorApp extends StatelessWidget {
  const MyNavigatorApp({super.key});

  final bool _isDeepLink = false;

  @override
  Widget build(BuildContext context) {
    debugPrint("deep link: $_isDeepLink");
    return MaterialApp(
      // 간단한 화면 전환
      // initialRoute: 'HomeScreen',
      // routes: {
      //   'HomeScreen': (context) => const HomeScreen(),
      //   'SecondScreen': (context) => const SecondScreen(),
      //   'ThirdScreen': (context) => const ThirdScreen(),
      //   'FourthScreen': (context) => const FourthScreen(),
      // },
      // Navigation Bar
      title: 'Navigation Bar Test',
      theme: ThemeData(useMaterial3: true),
      home: const NavigationBarExample(),
      // title: 'Navigator Test',
      // home: Navigator(
      //   pages: [
      //     const MaterialPage(
      //       child: HomeScreen(),
      //     ),
      //     if (_isDeepLink == true) const MaterialPage(child: SecondScreen())
      //   ],
      //   onPopPage: (route, result) => route.didPop(result),
      // ),
    );
  }
}
