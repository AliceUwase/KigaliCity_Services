import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'my_listings_screen.dart';
import 'map_view_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<bool> _loadedScreens = [true, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          const HomeScreen(),
          _loadedScreens[1]
              ? const MyListingsScreen()
              : const SizedBox.shrink(),
          _loadedScreens[2] ? const MapViewScreen() : const SizedBox.shrink(),
          _loadedScreens[3] ? const ProfileScreen() : const SizedBox.shrink(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _loadedScreens[index] = true;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Directory',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted),
            label: 'My Listings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: 'Map View',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
