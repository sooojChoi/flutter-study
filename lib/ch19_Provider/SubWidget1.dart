import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test1/ch19_Provider/main.dart';

class SubWidget1 extends StatelessWidget {
  const SubWidget1({super.key});

  @override
  Widget build(BuildContext context) {
    // provider로 상태 데이터 가져옴
    var counter = Provider.of<Counter>(context);
    var mode = Provider.of<Mode>(context);
    var numberInt = Provider.of<int>(context);
    var text = Provider.of<String>(context);
    var numberDouble = Provider.of<double>(context);

    onPressed() {
      counter.increment();
    }

    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Text(
        //   "counter: ${counter.count.toString()}",
        //   style: const TextStyle(
        //     fontSize: 20,
        //   ),
        // ),
        // Consumer를 사용하면 Provider.of로 상태에 접근하지 않아도 된다.
        Consumer<Counter>(builder: (context, model, child) {
          return Text(
            model.count.toString(),
            style: const TextStyle(
              fontSize: 20,
            ),
          );
        }),
        ElevatedButton(
          onPressed: onPressed,
          child: const Text(
            "plus 1",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        Text(
          "int: $numberInt, double: $numberDouble",
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          "text: $text",
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            mode.changeMode();
          },
          child: Text(
            "mode: ${mode.mode}",
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        Selector<Mode, String>(
            builder: (context, data, child) {
              return Text(
                data,
                style: const TextStyle(
                  fontSize: 20,
                ),
              );
            },
            selector: (context, model) => model.mode),
      ],
    ));
  }
}
