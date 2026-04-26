import 'package:flutter/material.dart';
import 'package:hotel_app/features/booking/presentation/pages/rooms_page.dart';
import 'package:hotel_app/features/orders/presentation/pages/services_page.dart';
import 'package:hotel_app/features/orders/presentation/pages/notifications_page.dart';
import 'package:hotel_app/features/admin/presentation/pages/admin_dashboard_page.dart';
import 'package:hotel_app/features/profile/presentation/pages/profile_page.dart';

class MainScreen extends StatefulWidget {
  final String userPhone;
  const MainScreen({Key? key, required this.userPhone}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  
  // ADMIN TELEFON RAQAMI
  final String adminPhone = "+998975960976"; 

  // Admin ekanligini tekshirish (faqat shu nomer bo'lsa)
  bool get isAdmin => widget.userPhone.replaceAll(' ', '') == adminPhone;

  List<Widget> get _pages {
    return [
      const RoomsPage(),
      const ServicesPage(),
      const NotificationsPage(),
      if (isAdmin) const AdminDashboardPage(),
      ProfilePage(userPhone: widget.userPhone),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.length > _currentIndex ? _pages[_currentIndex] : _pages[0],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.hotel),
            label: 'Xonalar',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.room_service),
            label: 'Xizmatlar',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Bildirishnomalar',
          ),
          if (isAdmin)
            const BottomNavigationBarItem(
              icon: Icon(Icons.admin_panel_settings),
              label: 'Admin',
            ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
