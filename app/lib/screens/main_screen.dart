import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'favorites_screen.dart';
import 'chat_screen.dart';
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

  late List screens;

  @override
  void initState() {

    super.initState();

    screens = [

      HomeScreen(
        userData: widget.userData,
      ),

      FavoritesScreen(
        userData: widget.userData,
      ),

      ChatScreen(
        userData: widget.userData,
      ),

      ProfileScreen(
        userData: widget.userData,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {

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

          BottomNavigationBarItem(

            icon: Icon(Icons.chat),

            label: "Чат",
          ),

          BottomNavigationBarItem(

            icon: Icon(Icons.person),

            label: "Профиль",
          ),
        ],
      ),
    );
  }
}