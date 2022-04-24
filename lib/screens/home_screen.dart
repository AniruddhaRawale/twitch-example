import 'package:flutter/material.dart';
import 'package:flutter_twitch_clone_final/Providers/user_provider.dart';
import 'package:flutter_twitch_clone_final/Utills/colors.dart';
import 'package:flutter_twitch_clone_final/screens/feed_screen.dart';
import 'package:flutter_twitch_clone_final/screens/go_live_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;

  List<Widget> pages = [
    const FeedScreen(),
    const GoLiveScreen(),
    const Center(child: Text("Browser"),)
  ];

  onPageChange(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: buttonColor,
        unselectedItemColor: primaryColor,
        backgroundColor: backgroundColor,
        unselectedFontSize: 12,
        onTap: onPageChange,
        currentIndex: _page,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Following'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_rounded), label: 'Go Live'),
          BottomNavigationBarItem(icon: Icon(Icons.copy), label: 'Browse')
        ],
      ),
      body: pages[_page],
    );
  }
}
