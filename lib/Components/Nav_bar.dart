import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_pr/Auth/login_screen.dart'; // Ensure this package is included in your pubspec.yaml

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _page = 0;
  final List<Widget> _pages = [AuthPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: prefer_const_constructors
      appBar: AppBar(
        title: Center(
          child: Text(
            'Cellule',
            style: TextStyle(fontSize: 18, fontFamily: 'RobotoMono'),
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.blue[400],
        color: Colors.blue,
        animationDuration: const Duration(milliseconds: 300),
        items: const <Widget>[
          Icon(Icons.home, size: 26, color: Colors.white),
          Icon(Icons.message, size: 26, color: Colors.white),
          Icon(Icons.add, size: 26, color: Colors.white),
          Icon(Icons.notifications, size: 26, color: Colors.white),
          Icon(Icons.person, size: 26, color: Colors.white),
        ],
         onTap: (index) {
          setState(() {
            if (index == 4) {
              // Navigate to AuthPage if profile icon is tapped
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AuthPage()),
              );
            } else {
              _page = index;
            }
          });
        },
      ),
    );
  }
}
