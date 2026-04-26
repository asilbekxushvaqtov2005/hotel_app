import '../entities/booking.dart';
import '../entities/room.dart';

abstract class BookingRepository {
  Future<List<Room>> getAvailableRooms(DateTime checkIn, DateTime checkOut);
  
  Future<Booking> bookRoom({
    required String roomId,
    required String userId,
    required DateTime checkIn,
    required DateTime checkOut,
  });
  
  Stream<List<Booking>> getUserBookings(String userId);

  Stream<List<Booking>> getAllBookings();

  Future<void> updateBookingStatus(String bookingId, String status);
}
