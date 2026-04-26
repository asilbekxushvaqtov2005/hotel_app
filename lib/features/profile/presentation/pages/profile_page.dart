import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../features/auth/presentation/pages/login_page.dart';

class ProfilePage extends StatelessWidget {
  final String userPhone;
  const ProfilePage({Key? key, required this.userPhone}) : super(key: key);

  Future<void> _launchTelegram() async {
    const String telegramUsername = "alimardon0101"; // username'ni @ belgisiz yozing
    final Uri url = Uri.parse('https://t.me/$telegramUsername');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Telegramni ochib bo\'lmadi');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            tooltip: 'Chiqish',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Chiqish'),
                  content: const Text('Haqiqatan ham hisobingizdan chiqmoqchimisiz?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Bekor qilish'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                          (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text('Chiqish', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundColor: Colors.orange,
              child: Icon(Icons.person, size: 80, color: Colors.white),
            ),
            const SizedBox(height: 20),
            const Text(
              'Asilbek Xushvaqtov',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              userPhone,
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(height: 40),
            _buildProfileItem(Icons.person_outline, 'Shaxsiy ma\'lumotlar', () {}),
            _buildProfileItem(Icons.history, 'Mening bronlarim', () {}),
            _buildProfileItem(Icons.settings_outlined, 'Sozlamalar', () {}),
            _buildProfileItem(Icons.help_outline, 'Yordam markazi', _launchTelegram),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                   Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.logout, color: Colors.red),
                label: const Text('Tizimdan chiqish', style: TextStyle(color: Colors.red)),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  side: const BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.orange),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
