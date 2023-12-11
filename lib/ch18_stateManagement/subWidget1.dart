import 'package:flutter/material.dart';
import 'package:test1/ch18_stateManagement/InheritedWidget.dart';
import 'package:test1/ch18_stateManagement/parentWidget.dart';

class SubWidget1 extends StatelessWidget {
  Function addNum;
  Function resetNum;

  SubWidget1({
    super.key,
    required this.addNum,
    required this.resetNum,
  });

  onPlusPressed() {
    addNum();
  }

  onResetPressed() {
    resetNum();
  }

  @override
  Widget build(BuildContext context) {
    // findAncestorStateOfType를 사용하여 상위 위젯의 상태에 접근할 수 있다.
    ParentWidgetState? state =
        context.findAncestorStateOfType<ParentWidgetState>();
    var text = state?.num.toString() ?? "empty";
    var heart = state?.heart ?? false;

    int count = MyInheritedWidget.of(context)!.count;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                heart
                    ? const Icon(Icons.lightbulb)
                    : const Icon(Icons.lightbulb_outline),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  count.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                )
              ],
            ),
            IconButton(
              color: Colors.green,
              onPressed: onPlusPressed,
              icon: const Icon(
                Icons.plus_one_rounded,
                color: Colors.black,
              ),
            ),
            ElevatedButton(
              onPressed: onResetPressed,
              child: const Text(
                "Reset",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
