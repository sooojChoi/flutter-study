import 'package:flutter/material.dart';

void main() {
  runApp(MyWidget());
}

class MyWidget extends StatelessWidget {
  MyWidget({super.key});
  List<int> myNumbers = [];

  int calcFun(int x) {
    myNumbers.add(x);
    return x;
  }

  Stream test() {
    Duration duration = const Duration(seconds: 2);
    // calcFun에 넘겨지는 매개변수는 0부터 시작해서 매 호출마다 1씩 증가.
    Stream<int> stream = Stream<int>.periodic(duration, calcFun);
    stream = stream.take(4);

    return stream;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Center(
        child: StreamBuilder(
          stream: test(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Completed.',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'data: ${snapshot.data}',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const Text(
                    'All data: ',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  for (int value in myNumbers)
                    Text(
                      "$value",
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    )
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Waiting.',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'data: ${snapshot.data}',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              );
            }
            return Text(
              'data: ${snapshot.data}',
              style: const TextStyle(
                fontSize: 20,
              ),
            );
          },
        ),
      )),
    );
  }
}
