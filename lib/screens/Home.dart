import 'package:budget_tracker/screens/Profile.dart';
import 'package:budget_tracker/screens/TrackerPage.dart';
import 'package:flutter/material.dart';

class HomeFrame extends StatefulWidget {
  const HomeFrame({Key? key}) : super(key: key);

  @override
  State<HomeFrame> createState() => _HomeFrameState();
}

class _HomeFrameState extends State<HomeFrame> {

  List<BottomNavigationBarItem> bottomNavItems = const[
    BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.account_circle),label: "Profile",)
  ];
  List<Widget> pages = const [
    TrackerPage(),
    UserProfile(),
  ];
  var _currentIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        bottomNavigationBar: BottomNavigationBar(
          items: bottomNavItems,
          currentIndex: _currentIndex,
          onTap: (index){
            setState(() {
              _currentIndex=index;
            });
          },

        ),
      body: pages[_currentIndex],
    );
  }
}
