import 'package:flutter/material.dart';
import 'package:test1/nomad/WebToonApp/screens/home_screen.dart';

void main() {
  runApp(const MyWebtoonApp());
}

class MyWebtoonApp extends StatelessWidget {
  const MyWebtoonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
