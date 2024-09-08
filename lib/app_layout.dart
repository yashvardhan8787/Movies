import 'package:flutter/material.dart';
import 'package:movies/view/home_view.dart';
import 'package:movies/view/screen_four_view.dart';
import 'package:movies/view/screen_three_view.dart';
import 'package:movies/view/screen_two_view.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({super.key});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static final List<Widget> _pages = <Widget>[
    MyHomePage(),
    ScreenTwoView(),
    ScreenThreeView(),
    ScreenFourView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text("Bottom Navigation and AppBar"),
        centerTitle: true,
        actions: const [
          Icon(Icons.notifications),
          SizedBox(width: 20),
          Icon(Icons.account_circle_outlined),
          SizedBox(width: 10)
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_circle_down_rounded),
            label: 'Downloads',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Watchlist',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.white, // Set to a visible color
        selectedItemColor: Colors.blue, // Color for the selected item
        unselectedItemColor: Colors.grey, // Color for unselected items
      ),
      body: _pages[_selectedIndex],
    );
  }
}
