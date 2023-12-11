import 'package:flutter/material.dart';
import 'package:test1/ch18_stateManagement/parentWidget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: ParentWidget());
  }
}
