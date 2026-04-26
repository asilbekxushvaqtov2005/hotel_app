import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/booking.dart';

class BookingModel extends Booking {
  const BookingModel({
    required super.id,
    required super.userId,
    required super.roomId,
    required super.checkIn,
    required super.checkOut,
    required super.totalPrice,
    required super.status,
    required super.createdAt,
  });

  factory BookingModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return BookingModel(
      id: doc.id,
      userId: data['userId'] ?? '',
      roomId: data['roomId'] ?? '',
      checkIn: (data['checkIn'] as Timestamp).toDate(),
      checkOut: (data['checkOut'] as Timestamp).toDate(),
      totalPrice: (data['totalPrice'] ?? 0).toDouble(),
      status: data['status'] ?? 'Pending',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'roomId': roomId,
      'checkIn': Timestamp.fromDate(checkIn),
      'checkOut': Timestamp.fromDate(checkOut),
      'totalPrice': totalPrice,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
