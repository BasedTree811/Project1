import 'package:flutter/material.dart';

import 'admin_screen.dart';
import 'favorites_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {

  final Map userData;

  const MainScreen({
    super.key,
    required this.userData,
  });

  @override
  State<MainScreen> createState() =>
      _MainScreenState();
}

class _MainScreenState
    extends State<MainScreen> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    List screens = [

      HomeScreen(
        userData: widget.userData,
      ),

      FavoritesScreen(
        userData: widget.userData,
      ),

      ProfileScreen(
        userData: widget.userData,
      ),
    ];

    if (widget.userData["role"] ==
        "admin") {

      screens.add(
        const AdminScreen(),
      );
    }

    return Scaffold(

      body: screens[currentIndex],

      bottomNavigationBar:
      BottomNavigationBar(

        currentIndex: currentIndex,

        onTap: (index) {

          setState(() {
            currentIndex = index;
          });
        },

        items: [

          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Главная",
          ),

          const BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Избранное",
          ),

          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Профиль",
          ),

          if (widget.userData["role"] ==
              "admin")

            const BottomNavigationBarItem(
              icon: Icon(Icons.admin_panel_settings),
              label: "Admin",
            ),
        ],
      ),
    );
  }
}