import 'package:flutter/material.dart';
import 'package:test1/ch14_navigator/widgets/screen_button.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? arg;
    if (ModalRoute.of(context)?.settings.arguments != null) {
      arg = ModalRoute.of(context)?.settings.arguments as String;
    }

    debugPrint(arg);
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
              'Third Screen 입니다. ',
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
          navigatorName: "secondScreen",
          popType: true,
        ),
        const SizedBox(
          height: 10,
        ),
        ScreenButton(
          buttonText: "Fourth Screen",
          navigatorName: "FourthScreen",
        ),
        if (arg != null)
          const SizedBox(
            height: 15,
          ),
        if (arg != null)
          Text(
            arg,
            style: const TextStyle(
              fontSize: 20,
            ),
          )
      ]),
    );
  }
}
