import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final void Function(int) setScreenIndex;
  final int screenIndex;

  const BottomNav({
    super.key,
    required this.setScreenIndex,
    required this.screenIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: screenIndex,
      onTap: (index) => setScreenIndex(index),
      items: const <BottomNavigationBarItem>[
        // Home
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),

        // Camera
        BottomNavigationBarItem(icon: Icon(Icons.add), label: 'New Post'),

        // Notifications
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Notifications',
        ),

        // Profile
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
