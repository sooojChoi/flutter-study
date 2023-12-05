import 'package:flutter/material.dart';
import 'package:test1/ch14_navigator/widgets/screen_button.dart';

class FourthScreen extends StatelessWidget {
  const FourthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2, // 음영 조절
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: const Text('Second Screen'),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Fourth Screen 입니다. ',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 25,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        ScreenButton(
          buttonText: "돌아가기",
          navigatorName: "thirdScreen",
          popType: true,
        ),
        const SizedBox(
          height: 10,
        ),
        ScreenButton(
          buttonText: "Home Screen",
          navigatorName: "HomeScreen",
          popType: true,
        )
      ]),
    );
  }
}
