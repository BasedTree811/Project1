import 'package:flutter/material.dart';

import 'favorites_screen.dart';
import 'home_screen.dart';

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

      const FavoritesScreen(),
    ];

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

        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Главная",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Избранное",
          ),
        ],
      ),
    );
  }
}