import 'package:flutter/material.dart';
import './citys_screen.dart';
import 'settings_screen.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, Object>> _pages = [
    {
      'page': CitysScreen(),
      'fab': FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        onPressed: () {},
        tooltip: 'Suche',
        child: Icon(
          Icons.search,
          color: Colors.white,
        ),
      ),
    },
    {
      'page': SettingsScreen(),
      'fab': null,
    }
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex]['page'],
      extendBody: true,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.blueGrey[300],
        selectedItemColor: Colors.white,
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Einstellungen',
          ),
        ],
      ),
      floatingActionButton: _pages[_selectedPageIndex]['fab'],
    );
  }
}
