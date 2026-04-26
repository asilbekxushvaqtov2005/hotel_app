import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/booking_bloc.dart';
import '../bloc/booking_state.dart';
import '../bloc/booking_event.dart';
import '../widgets/room_card.dart';
import '../../domain/entities/room.dart';
import 'booking_details_page.dart';

class RoomsPage extends StatefulWidget {
  const RoomsPage({Key? key}) : super(key: key);

  @override
  State<RoomsPage> createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
  DateTime _checkIn = DateTime.now();
  DateTime _checkOut = DateTime.now().add(const Duration(days: 1));

  @override
  void initState() {
    super.initState();
    context.read<BookingBloc>().add(LoadAvailableRoomsEvent(
      checkIn: _checkIn,
      checkOut: _checkOut,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gorgeous Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Mukammal',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const Text(
                    'Xonani Tanlang',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Date Picker Mock UI
                  Row(
                    children: [
                      _buildDateCard('Check In', '${_checkIn.day}/${_checkIn.month}'),
                      const SizedBox(width: 10),
                      const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
                      const SizedBox(width: 10),
                      _buildDateCard('Check Out', '${_checkOut.day}/${_checkOut.month}'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            
            // Rooms List
            Expanded(
              child: BlocBuilder<BookingBloc, BookingState>(
                builder: (context, state) {
                  if (state is BookingLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is AvailableRoomsLoaded) {
                    if (state.rooms.isEmpty) {
                      return _buildEmptyState(); // Show mock data if fully empty just for UI dev
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.all(24),
                      itemCount: state.rooms.length,
                      itemBuilder: (context, index) {
                        return RoomCard(
                          room: state.rooms[index],
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookingDetailsPage(room: state.rooms[index]),
                              ),
                            );
                          },
                        );
                      },
                    );
                  } else if (state is BookingError) {
                    return Center(child: Text(state.message, style: const TextStyle(color: Colors.red)));
                  }
                  
                  // For UI preview, if state is Initial or Empty, show Fake Mocks
                  return _buildMockRooms();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateCard(String title, String date) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.05),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.blue.withOpacity(0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 4),
            Text(date, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
     return const Center(child: Text("Hech narsa topilmadi!"));
  }

  // Temporary function just to show how UI looks if Firestore is empty
  Widget _buildMockRooms() {
    List<Room> mockRooms = [
      const Room(
        id: '1',
        roomNumber: '101',
        type: 'President Suite',
        pricePerNight: 250,
        images: [],
        amenities: ['Wi-Fi', 'TV', 'Minibar', 'Pool View'],
      ),
      const Room(
        id: '2',
        roomNumber: '102',
        type: 'Deluxe Double',
        pricePerNight: 120,
        images: [],
        amenities: ['Wi-Fi', 'TV', 'Air Conditioning'],
      )
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: mockRooms.length,
      itemBuilder: (context, index) {
        return RoomCard(
          room: mockRooms[index],
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookingDetailsPage(room: mockRooms[index]),
              ),
            );
          },
        );
      },
    );
  }
}
