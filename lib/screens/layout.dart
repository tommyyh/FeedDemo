import 'package:feed_demo/screens/home/home_screen.dart';
import 'package:feed_demo/screens/my_profile/my_profile_screen.dart';
import 'package:feed_demo/screens/new_post/new_post_screen.dart';
import 'package:feed_demo/screens/notifications/notifications_screen.dart';
import 'package:feed_demo/widgets/bottom_nav/bottom_nav.dart';
import 'package:flutter/material.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int screenIndex = 0;

  void setScreenIndex(int index) {
    setState(() {
      screenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNav(
        setScreenIndex: setScreenIndex,
        screenIndex: screenIndex,
      ),
      // Use Indexed Stack + AutomaticKeepAliveClientMixin -> Keep scroll position
      body: IndexedStack(
        index: screenIndex,
        children: const [
          HomeScreen(),
          NewPostScreen(),
          NotificationsScreen(),
          MyProfileScreen(),
        ],
      ),
    );
  }
}
