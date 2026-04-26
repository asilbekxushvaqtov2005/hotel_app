import 'package:equatable/equatable.dart';

class Order extends Equatable {
  final String id;
  final String userId;
  final String bookingId;
  final String serviceType; // e.g. "Taxi", "Cleaning", "Restaurant"
  final String status; // e.g. "Pending", "InProgress", "Completed"
  final Map<String, dynamic> details;
  final DateTime createdAt;

  const Order({
    required this.id,
    required this.userId,
    required this.bookingId,
    required this.serviceType,
    required this.status,
    required this.details,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        bookingId,
        serviceType,
        status,
        details,
        createdAt,
      ];
}
