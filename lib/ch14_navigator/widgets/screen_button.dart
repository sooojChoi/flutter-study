import 'package:flutter/material.dart';

class ScreenButton extends StatelessWidget {
  final String buttonText; // 버튼에 표시될 텍스트
  final String navigatorName; // 실제로 이동할 화면 이름
  bool popType; //  pop이면 true로 설정
  String? arguments; // 새로운 화면으로 전달할 데이터

  ScreenButton({
    super.key,
    required this.buttonText,
    required this.navigatorName,
    this.popType = false,
    this.arguments,
  });

  goToScreen(context) {
    // 해당 화면으로 이동한다.
    if (arguments == null) {
      Navigator.pushNamed(context, navigatorName);
    } else {
      Navigator.pushNamed(context, navigatorName, arguments: arguments);
      debugPrint("sendText: $arguments");
    }
  }

  popScreen(context) {
    Navigator.maybePop(context);
    if (navigatorName == 'HomeScreen') {
      Navigator.popUntil(context, ModalRoute.withName('HomeScreen'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {popType ? popScreen(context) : goToScreen(context)},
      child: Container(
        alignment: Alignment.center,
        width: 200,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.green[300],
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                offset: const Offset(3, 5),
                color: Colors.black.withOpacity(0.7),
              ),
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 11),
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
