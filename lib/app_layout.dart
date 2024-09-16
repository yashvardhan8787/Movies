import 'package:flutter/material.dart';
import 'package:movies/view/home_view.dart';
import 'package:movies/view/screen_three_view.dart';
import 'package:movies/view/search_page_view.dart';
import 'package:movies/view/watch_liste_page_view.dart';

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
    SearchPageView(),
    ScreenThreeView(),
    WatchlistPageView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu, color: Colors.white),
        backgroundColor: Colors.blue,
        title: const Text(
          "Movies",
          style: TextStyle(color: Colors.white),
        ),
        actions: const [
          Icon(Icons.notifications, color: Colors.white),
          SizedBox(width: 20),
          Icon(Icons.account_circle_outlined, color: Colors.white),
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
        backgroundColor: Colors.blue, // Set background color here
        selectedItemColor: Colors.black, // Ensure the selected item color stands out
        unselectedItemColor: Colors.white, // Color for unselected items
        type: BottomNavigationBarType.fixed, // Fixed type ensures background color works
      ),
      body: _pages[_selectedIndex],
    );
  }
}
