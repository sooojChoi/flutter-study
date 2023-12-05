import 'package:flutter/material.dart';
import 'package:test1/ch14_navigator/widgets/screen_button.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final controller = TextEditingController();
  String textToSend = "";

  @override
  void initState() {
    super.initState();

    // controller가 등록된 텍스트 값이 바뀔 때마다 내부 함수 호출됨.
    controller.addListener(() {});
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

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
              'Second Screen 입니다. ',
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
          navigatorName: "homeScreen",
          popType: true,
        ),
        const SizedBox(
          height: 10,
        ),
        ScreenButton(
          buttonText: "Third Screen",
          navigatorName: "ThirdScreen",
          arguments: textToSend,
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: TextField(
            style: const TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.left,
            controller: controller,
            decoration: const InputDecoration(hintText: "전달할 데이터를 입력하시오."),
            onChanged: (value) {
              textToSend = value;
              setState(() {});
            },
          ),
        )
      ]),
    );
  }
}
