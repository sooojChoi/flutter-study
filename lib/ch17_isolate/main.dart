import 'dart:async';
import 'dart:isolate';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

myIsolate(SendPort mainSendPort) {
  ReceivePort receivePort = ReceivePort();
  debugPrint("mainIsolate로 sendPort 보냄");
  mainSendPort.send({'port': receivePort.sendPort});
  receivePort.listen((message) {
    if (message['msg'] != 'bye') {
      int count = message['msg'];
      mainSendPort.send({'msg': count * count});
    } else {
      receivePort.close();
    }
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var sum = 0;

  onPressed() async {
    ReceivePort mainReceivePort = ReceivePort();
    await Isolate.spawn(myIsolate, mainReceivePort.sendPort);

    SendPort? isoSendPort;
    mainReceivePort.listen((message) {
      if (message['port'] != null) {
        isoSendPort = message['port'];
        debugPrint("myIsolate로부터 sendport 받음");
      } else if (message['msg'] != null) {
        setState(() {
          sum = message['msg'];
        });
      }
    });

    int count = 0;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      count++;
      if (count < 6) {
        debugPrint("myIsolate로 msg:$count 보냄");
        isoSendPort?.send({'msg': count});
      } else {
        debugPrint("myIsolate로 msg:bye 보냄");
        isoSendPort?.send({'msg': 'bye'});
        setState(() {
          sum = 0;
        });
        mainReceivePort.close();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "sum: ${sum.toString()}",
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: onPressed,
                    child: const Text(
                      'isolate start!',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
