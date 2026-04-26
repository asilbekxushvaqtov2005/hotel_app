import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/booking_model.dart';
import '../models/room_model.dart';

abstract class BookingRemoteDataSource {
  Future<List<RoomModel>> getAvailableRooms(DateTime checkIn, DateTime checkOut);
  Future<BookingModel> bookRoom({
    required String roomId,
    required String userId,
    required DateTime checkIn,
    required DateTime checkOut,
  });
  Stream<List<BookingModel>> getUserBookings(String userId);
  Stream<List<BookingModel>> getAllBookings();
  Future<void> updateBookingStatus(String bookingId, String status);
}

class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  final FirebaseFirestore firestore;

  BookingRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<RoomModel>> getAvailableRooms(DateTime checkIn, DateTime checkOut) async {
    final snapshot = await firestore.collection('rooms').get();
    return snapshot.docs.map((doc) => RoomModel.fromFirestore(doc)).toList();
  }

  @override
  Future<BookingModel> bookRoom({
    required String roomId,
    required String userId,
    required DateTime checkIn,
    required DateTime checkOut,
  }) async {
    final bookingRef = firestore.collection('bookings').doc();

    await firestore.runTransaction((transaction) async {
      final overlappingBookingsSnapshot = await firestore
          .collection('bookings')
          .where('roomId', isEqualTo: roomId)
          .where('status', whereIn: ['Confirmed', 'Pending'])
          .get();

      bool isOverlap = false;

      for (var doc in overlappingBookingsSnapshot.docs) {
        final existingIn = (doc['checkIn'] as Timestamp).toDate();
        final existingOut = (doc['checkOut'] as Timestamp).toDate();

        if (checkIn.isBefore(existingOut) && checkOut.isAfter(existingIn)) {
          isOverlap = true;
          break;
        }
      }

      if (isOverlap) {
        throw Exception('Kechirasiz, ushbu xona ko\'rsatilgan sanalarda allaqachon band qilingan!');
      }

      final bookingModel = BookingModel(
        id: bookingRef.id,
        userId: userId,
        roomId: roomId,
        checkIn: checkIn,
        checkOut: checkOut,
        totalPrice: 100.0,
        status: 'Pending',
        createdAt: DateTime.now(),
      );

      transaction.set(bookingRef, bookingModel.toFirestore());
    });

    final docSnapshot = await bookingRef.get();
    return BookingModel.fromFirestore(docSnapshot);
  }

  @override
  Stream<List<BookingModel>> getUserBookings(String userId) {
    return firestore
        .collection('bookings')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => BookingModel.fromFirestore(doc)).toList());
  }

  @override
  Stream<List<BookingModel>> getAllBookings() {
    return firestore
        .collection('bookings')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => BookingModel.fromFirestore(doc)).toList());
  }

  @override
  Future<void> updateBookingStatus(String bookingId, String status) async {
    await firestore.collection('bookings').doc(bookingId).update({'status': status});
  }
}
