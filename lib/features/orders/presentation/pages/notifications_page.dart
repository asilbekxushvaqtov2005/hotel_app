import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/notification_bloc.dart';
import '../bloc/notification_state.dart';
import '../bloc/notification_event.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationBloc>().add(LoadNotificationsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bildirishnomalar', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoaded) {
            if (state.notifications.isEmpty) {
              return const Center(child: Text('Bildirishnomalar yo\'q'));
            }
            return ListView.separated(
              padding: const EdgeInsets.all(24),
              itemCount: state.notifications.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final item = state.notifications[index];
                return _buildNotificationCard(
                  item.title,
                  item.desc,
                  item.type == 'service' ? Icons.room_service : Icons.info,
                  item.type == 'service' ? Colors.blue : Colors.green,
                  item.time,
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildNotificationCard(String title, String desc, IconData icon, Color color, String time) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 4),
            blurRadius: 10,
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                    Text(time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 5),
                Text(desc, style: const TextStyle(color: Colors.grey, fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
