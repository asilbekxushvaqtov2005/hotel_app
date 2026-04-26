import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/features/booking/domain/repositories/booking_repository.dart';
import 'package:hotel_app/features/booking/domain/usecases/book_room_usecase.dart';
import 'package:hotel_app/features/booking/domain/entities/room.dart';
import 'package:hotel_app/features/booking/domain/entities/booking.dart';
import 'package:hotel_app/features/booking/presentation/bloc/booking_bloc.dart';
import 'package:hotel_app/features/admin/presentation/bloc/admin_bloc.dart';
import 'package:hotel_app/features/orders/presentation/bloc/notification_bloc.dart';
import 'package:hotel_app/features/auth/presentation/pages/login_page.dart';

// Improved Mock Repository with memory state
class MockBookingRepository implements BookingRepository {
  final List<Booking> _bookings = [
    Booking(
      id: 'ID-A12B',
      userId: 'user1',
      roomId: '101',
      checkIn: DateTime.now(),
      checkOut: DateTime.now().add(const Duration(days: 2)),
      totalPrice: 200.0,
      status: 'Pending',
      createdAt: DateTime.now(),
    ),
  ];

  final _bookingsController = StreamController<List<Booking>>.broadcast();

  MockBookingRepository() {
    _bookingsController.add(_bookings);
  }

  @override
  Future<List<Room>> getAvailableRooms(DateTime checkIn, DateTime checkOut) async {
    await Future.delayed(const Duration(seconds: 1)); 
    return [
      const Room(
        id: '1',
        roomNumber: '101',
        type: 'President Suite',
        pricePerNight: 250.0,
        images: ['https://images.unsplash.com/photo-1590490360182-c33d57733427?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60'],
        amenities: ['Wi-Fi', 'TV', 'Minibar', 'Pool View'],
      ),
      const Room(
        id: '2',
        roomNumber: '102',
        type: 'Deluxe Double',
        pricePerNight: 120.0,
        images: ['https://images.unsplash.com/photo-1566665797739-1674de7a421a?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60'],
        amenities: ['Wi-Fi', 'TV', 'Air Conditioning'],
      ),
    ];
  }

  @override
  Future<Booking> bookRoom({required String roomId, required String userId, required DateTime checkIn, required DateTime checkOut}) async {
    final newBooking = Booking(
      id: 'BRN-${DateTime.now().millisecondsSinceEpoch}',
      userId: userId,
      roomId: roomId,
      checkIn: checkIn,
      checkOut: checkOut,
      totalPrice: 200.0,
      status: 'Pending',
      createdAt: DateTime.now(),
    );
    _bookings.insert(0, newBooking);
    _bookingsController.add(List.from(_bookings));
    return newBooking;
  }

  @override
  Stream<List<Booking>> getUserBookings(String userId) {
    return _bookingsController.stream.map(
      (list) => list.where((b) => b.userId == userId).toList()
    );
  }

  @override
  Stream<List<Booking>> getAllBookings() {
    Timer.run(() => _bookingsController.add(List.from(_bookings)));
    return _bookingsController.stream;
  }

  @override
  Future<void> updateBookingStatus(String bookingId, String status) async {
    final index = _bookings.indexWhere((b) => b.id == bookingId);
    if (index != -1) {
      final old = _bookings[index];
      _bookings[index] = Booking(
        id: old.id,
        userId: old.userId,
        roomId: old.roomId,
        checkIn: old.checkIn,
        checkOut: old.checkOut,
        totalPrice: old.totalPrice,
        status: status,
        createdAt: old.createdAt,
      );
      _bookingsController.add(List.from(_bookings));
    }
  }
}

void main() {
  runApp(const HotelApp());
}

class HotelApp extends StatelessWidget {
  const HotelApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mockRepo = MockBookingRepository();
    
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BookingBloc(
            repository: mockRepo,
            bookRoomUseCase: BookRoomUseCase(mockRepo),
          ),
        ),
        BlocProvider(
          create: (context) => AdminBloc(
            repository: mockRepo,
          ),
        ),
        BlocProvider(
          create: (context) => NotificationBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Hotel Ecosystem',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
          fontFamily: 'Inter',
        ),
        home: const LoginPage(),
      ),
    );
  }
}
