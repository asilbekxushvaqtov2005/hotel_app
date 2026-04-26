import 'package:equatable/equatable.dart';

class Booking extends Equatable {
  final String id;
  final String userId;
  final String roomId;
  final DateTime checkIn;
  final DateTime checkOut;
  final double totalPrice;
  final String status; // "Pending", "Confirmed", "Completed", "Cancelled"
  final DateTime createdAt;

  const Booking({
    required this.id,
    required this.userId,
    required this.roomId,
    required this.checkIn,
    required this.checkOut,
    required this.totalPrice,
    required this.status,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        roomId,
        checkIn,
        checkOut,
        totalPrice,
        status,
        createdAt,
      ];
}
