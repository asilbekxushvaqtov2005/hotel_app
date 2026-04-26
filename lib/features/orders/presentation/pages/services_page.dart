import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../admin/presentation/bloc/admin_bloc.dart';
import '../../../admin/presentation/bloc/admin_event.dart';
import '../../../booking/domain/entities/booking.dart';
import '../bloc/notification_bloc.dart';
import '../bloc/notification_event.dart';
import '../bloc/notification_state.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Xizmatlar', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(24),
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _buildServiceCard(context, Icons.restaurant, 'Ovqat', Colors.orange),
          _buildServiceCard(context, Icons.cleaning_services, 'Tozalash', Colors.blue),
          _buildServiceCard(context, Icons.local_taxi, 'Taxi', Colors.yellow.shade700),
          _buildServiceCard(context, Icons.room_service, 'Xona Servisi', Colors.purple),
        ],
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, IconData icon, String title, Color color) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(title),
            content: Text('$title xizmatini buyurtma qilmoqchimisiz?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Yo\'q'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  
                  final now = DateTime.now();
                  
                  // 1. Foydalanuvchi uchun bildirishnoma qo'shish
                  context.read<NotificationBloc>().add(
                    AddNotificationEvent(
                      NotificationItem(
                        title: '$title buyurtma qilindi',
                        desc: 'Sizning $title xizmati bo\'yicha so\'rovingiz qabul qilindi.',
                        time: 'Hozir',
                        type: 'service',
                      ),
                    ),
                  );

                  // 2. Adminga xizmat so'rovini yuborish (Booking sifatida)
                  context.read<AdminBloc>().add(
                    AddNewBookingEvent(
                      Booking(
                        id: 'SRV-${now.millisecondsSinceEpoch}',
                        userId: 'guest_user',
                        roomId: 'Xizmat: $title',
                        checkIn: now,
                        checkOut: now,
                        totalPrice: 0.0,
                        status: 'Pending',
                        createdAt: now,
                      ),
                    ),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$title xizmati qabul qilindi va adminga yuborildi!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                child: const Text('Ha'),
              ),
            ],
          ),
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
