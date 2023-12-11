import 'package:flutter/material.dart';
import 'package:test1/ch18_stateManagement/InheritedWidget.dart';
import 'package:test1/ch18_stateManagement/parentWidget.dart';

class SubWidget2 extends StatelessWidget {
  Function parentHeartFunc;
  SubWidget2({
    super.key,
    required this.parentHeartFunc,
  });

  @override
  Widget build(BuildContext context) {
    ParentWidgetState? state =
        context.findAncestorStateOfType<ParentWidgetState>();

    onPressed() {
      parentHeartFunc();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: onPressed,
          child: state!.heart
              ? const Text(
                  "light off",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )
              : const Text(
                  "light on",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
        )
      ],
    );
  }
}
