import 'package:flutter/material.dart';
import '../../../../booking/domain/entities/room.dart';
import '../../domain/entities/room.dart';

class RoomCard extends StatelessWidget {
  final Room room;
  final VoidCallback onTap;

  const RoomCard({Key? key, required this.room, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Room Image Placeholder
            Container(
              height: 160,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                color: Colors.grey.shade200,
                image: room.images.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(room.images.first),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: room.images.isEmpty
                  ? const Center(child: Icon(Icons.hotel, size: 50, color: Colors.grey))
                  : null,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Xona: ${room.roomNumber} (${room.type})',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '\$${room.pricePerNight} / tun',
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    children: room.amenities.map((amenity) {
                      return Chip(
                        label: Text(amenity, style: const TextStyle(fontSize: 12)),
                        padding: const EdgeInsets.all(0),
                        backgroundColor: Colors.grey.shade100,
                        side: BorderSide.none,
                      );
                    }).toList(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
