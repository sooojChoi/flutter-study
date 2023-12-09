import 'package:flutter/material.dart';
import 'package:test1/nomad/WebtoonApp/screens/NavigationBar.dart';

void main() {
  runApp(const MyWebtoonApp());
}

class MyWebtoonApp extends StatelessWidget {
  const MyWebtoonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NavigationBarScreen(),
    );
  }
}
