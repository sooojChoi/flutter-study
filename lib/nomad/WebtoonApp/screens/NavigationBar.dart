import 'package:flutter/material.dart';
import 'package:test1/nomad/WebtoonApp/screens/home_screen.dart';
import 'package:test1/nomad/WebtoonApp/screens/latest_screen.dart';

class NavigationBarScreen extends StatefulWidget {
  const NavigationBarScreen({super.key});

  @override
  State<NavigationBarScreen> createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  int currentPageIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    LatestScreen(),
  ];

  onItemTapped(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _widgetOptions.elementAt(currentPageIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onItemTapped,
        currentIndex: currentPageIndex,
        selectedItemColor: Colors.green[300],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.my_library_books_rounded),
            label: 'latest',
          ),
        ],
      ),
    );
  }
}
