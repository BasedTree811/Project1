import 'package:flutter/material.dart';
import 'history_screen.dart';
import 'login_screen.dart';
import 'rating_screen.dart';

class ProfileScreen extends StatelessWidget {
  final Map userData;

  const ProfileScreen({
    super.key,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
    // Безопасное извлечение данных
    final name = userData["name"]?.toString() ?? "Не указано";
    final email = userData["email"]?.toString() ?? "Не указано";
    final login = userData["login"]?.toString() ?? "Не указан";
    final rating = userData["rating"]?.toString() ?? "0";

    return Scaffold(
      backgroundColor: Colors.grey.shade50, // светлый фон

      appBar: AppBar(
        title: const Text(
          "Профиль",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // =====================
            // AVATAR
            // =====================
            Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Colors.deepPurple.shade400,
                      Colors.deepPurple.shade800,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurple.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.person,
                  size: 70,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // =====================
            // USER INFO CARD
            // =====================
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow("Имя:", name),
                    const SizedBox(height: 12),
                    _buildInfoRow("Email:", email),
                    const SizedBox(height: 12),
                    _buildInfoRow("Логин:", login),
                    const SizedBox(height: 12),
                    _buildInfoRow("Рейтинг:", rating),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // =====================
            // BUTTONS
            // =====================
            // История чтения
            SizedBox(
              height: 55,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.history, size: 24),
                label: const Text(
                  "История чтения",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HistoryScreen(userData: userData),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  elevation: 6,
                  shadowColor: Colors.deepPurple.withOpacity(0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Рейтинг читателей
            SizedBox(
              height: 55,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.leaderboard, size: 24),
                label: const Text(
                  "Рейтинг читателей",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const RatingScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  elevation: 6,
                  shadowColor: Colors.deepPurple.withOpacity(0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // =====================
            // LOGOUT
            // =====================
            SizedBox(
              height: 55,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.logout, size: 24),
                label: const Text(
                  "Выйти",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  elevation: 6,
                  shadowColor: Colors.redAccent.withOpacity(0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                        (route) => false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Вспомогательный виджет для строки информации
  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.deepPurple,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black87,
            ),
            softWrap: true,
          ),
        ),
      ],
    );
  }
}