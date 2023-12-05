import 'package:flutter/material.dart';
import 'package:test1/ch14_navigator/screens/fourthScreen.dart';
import 'package:test1/ch14_navigator/screens/homeScreen.dart';
import 'package:test1/ch14_navigator/screens/secondScreen.dart';
import 'package:test1/ch14_navigator/screens/thirdScreen.dart';

void main() {
  runApp(const MyNavigatorApp());
}

class MyNavigatorApp extends StatelessWidget {
  const MyNavigatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'HomeScreen',
      routes: {
        'HomeScreen': (context) => const HomeScreen(),
        'SecondScreen': (context) => const SecondScreen(),
        'ThirdScreen': (context) => const ThirdScreen(),
        'FourthScreen': (context) => const FourthScreen(),
      },
    );
  }
}
