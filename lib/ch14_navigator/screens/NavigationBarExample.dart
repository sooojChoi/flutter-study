import 'package:flutter/material.dart';
import 'package:test1/ch14_navigator/screens/homeScreen.dart';

class NavigationBarExample extends StatefulWidget {
  const NavigationBarExample({super.key});

  @override
  State<NavigationBarExample> createState() => _NavigationBarExampleState();
}

class _NavigationBarExampleState extends State<NavigationBarExample> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (value) {
          setState(() {
            currentPageIndex = value;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_none_rounded),
            label: 'Second',
          ),
          NavigationDestination(
            icon: Icon(Icons.message_rounded),
            label: 'Third',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_today_rounded),
            label: 'Fourth',
          ),
        ],
      ),
      body: [
        // Home
        const NavigationBarWidget(screenText: "첫 번째 화면입니다. "),

        //Second
        const NavigationBarWidget(screenText: "두 번째 화면입니다. "),

        // Third
        const NavigationBarWidget(screenText: "세 번째 화면입니다. "),

        // Fourth
        const NavigationBarWidget(screenText: "네 번째 화면입니다. "),
      ][currentPageIndex],
    );
  }
}

class NavigationBarWidget extends StatelessWidget {
  final String screenText;
  const NavigationBarWidget({
    super.key,
    required this.screenText,
  });

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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              screenText,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 25,
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
