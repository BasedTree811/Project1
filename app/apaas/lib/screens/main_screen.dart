import 'package:flutter/material.dart';
import 'history_screen.dart';
import 'home_screen.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  final Map userData;

  const MainScreen({
    super.key,
    required this.userData,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  late List screens;

  @override
  void initState() {
    super.initState();
    screens = [
      HomeScreen(userData: widget.userData),
      FavoritesScreen(userData: widget.userData),
      HistoryScreen(userData: widget.userData),
      ProfileScreen(userData: widget.userData),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurple.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.deepPurple,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
                if (index == 1) {
                  screens[1] = FavoritesScreen(userData: widget.userData);
                } else if (index == 2) {
                  screens[2] = HistoryScreen(userData: widget.userData);
                }
              });
            },
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 12,
            ),
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
                icon: Icon(Icons.history),
                label: "История",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Профиль",
              ),
            ],
          ),
        ),
      ),
    );
  }
}