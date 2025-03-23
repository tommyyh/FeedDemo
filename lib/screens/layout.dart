import 'package:feed_demo/screens/home/home_screen.dart';
import 'package:feed_demo/screens/new_post/new_post_screen.dart';
import 'package:feed_demo/widgets/bottom_nav/bottom_nav.dart';
import 'package:flutter/material.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int screenIndex = 0;

  // On tap -> Update screen
  void setScreenIndex(int index) {
    if (index + 1 > _pages.length) return; // Out of bounds redundancy

    setState(() {
      screenIndex = index;
    });
  }

  final List<Widget> _pages = [
    // Pages/Screens list
    const HomeScreen(),
    const NewPostScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNav(
        setScreenIndex: setScreenIndex,
        screenIndex: screenIndex,
      ),
      body: _pages[screenIndex],
    );
  }
}
