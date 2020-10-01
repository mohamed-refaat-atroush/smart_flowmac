import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'usage_screen.dart';
import 'setting_screen.dart';
import 'alert_screen.dart';
import 'control_screen.dart';

class NavigationPages extends StatefulWidget {
  static const String id = 'navigation_pages';
  @override
  _NavigationPagesState createState() => _NavigationPagesState();
}

class _NavigationPagesState extends State<NavigationPages> {
  int _currentIndex = 0;
  Widget callPages(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return UsageScreen();

      case 1:
        return ControlScreen();
      case 2:
        return AlertScreen();
      case 3:
        return SettingScreen();
        break;
      default:
        return UsageScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: callPages(_currentIndex),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.data_usage), title: Text('usage')),
            BottomNavigationBarItem(
                icon: Icon(Icons.control_point), title: Text('control')),
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.radiationAlt,
              ),
              title: Text('alert'),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), title: Text('setting')),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.signOutAlt),
              title: Text('log out'),
            ),
          ],
          onTap: (value) {
            setState(() {
              _currentIndex = value;
            });
            if (value == 4) {
              setState(() {
                Navigator.pop(context);
              });
            }
          },
        ),
      ),
    );
  }
}
