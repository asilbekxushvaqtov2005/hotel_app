import 'package:flutter/material.dart';
import '../../domain/entities/room.dart';

class BookingDetailsPage extends StatelessWidget {
  final Room room;

  const BookingDetailsPage({Key? key, required this.room}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Tasdiqlash', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Preview
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: room.images.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(room.images.first),
                        fit: BoxFit.cover,
                      )
                    : null,
                color: Colors.grey.shade200,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Xona ${room.roomNumber} - ${room.type}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              '\$${room.pricePerNight} / tun',
              style: const TextStyle(fontSize: 20, color: Colors.blue, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            
            const Text(
              'To\'lov Tafsilotlari',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  _buildRow('Xona narxi', '\$${room.pricePerNight}'),
                  const SizedBox(height: 10),
                  _buildRow('Soliqlar va yig\'imlar', '\$${(room.pricePerNight * 0.1).toStringAsFixed(2)}'),
                  const Divider(height: 30),
                  _buildRow(
                    'Jami summa',
                    '\$${(room.pricePerNight * 1.1).toStringAsFixed(2)}',
                    isTotal: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Bron qilinmoqda...')),
              );
              Navigator.pop(context); // Go back after logic completes
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Text('Tasdiqlash va To\'lash', style: TextStyle(fontSize: 16)),
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String title, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? Colors.black : Colors.grey.shade700,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: isTotal ? Colors.blue : Colors.black87,
          ),
        ),
      ],
    );
  }
}
