import 'package:flutter/material.dart';
import 'package:test1/ch14_navigator/widgets/screen_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2, // 음영 조절
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: const Text('네비게이션 테스트'),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'HomeScreen 입니다. ',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 25,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        ScreenButton(
          buttonText: "Second Screen",
          navigatorName: "SecondScreen",
        ),
        const SizedBox(
          height: 15,
        ),
        ScreenButton(
          buttonText: "Third Screen",
          navigatorName: "ThirdScreen",
        ),
        const SizedBox(
          height: 15,
        ),
        ScreenButton(
          buttonText: "Fourth Screen",
          navigatorName: "FourthScreen",
        ),
      ]),
    );
  }
}
