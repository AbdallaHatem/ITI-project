import 'package:flutter/material.dart';
import 'package:shopping_app/screens/HomeScreen.dart';
import 'package:shopping_app/screens/ProfilePage.dart';
import 'package:shopping_app/screens/Cart.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
        switch (index) {
          case 0:
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));            break;
          case 1:
            Navigator.push(context, MaterialPageRoute(builder: (context) => Cart()));            break;
          case 2:
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));             break;
                }
      },
      selectedItemColor: Colors.black, 
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.blue),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.store, color: Colors.blue),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person, color: Colors.blue),
          label: 'Profile',
        ),
      ],
    );
  }
}