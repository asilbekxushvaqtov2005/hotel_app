import '../../domain/entities/booking.dart';
import '../../domain/entities/room.dart';
import '../../domain/repositories/booking_repository.dart';
import '../datasources/booking_remote_data_source.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource remoteDataSource;

  BookingRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Room>> getAvailableRooms(DateTime checkIn, DateTime checkOut) async {
    return await remoteDataSource.getAvailableRooms(checkIn, checkOut);
  }

  @override
  Future<Booking> bookRoom({
    required String roomId,
    required String userId,
    required DateTime checkIn,
    required DateTime checkOut,
  }) async {
    return await remoteDataSource.bookRoom(
      roomId: roomId,
      userId: userId,
      checkIn: checkIn,
      checkOut: checkOut,
    );
  }

  @override
  Stream<List<Booking>> getUserBookings(String userId) {
    return remoteDataSource.getUserBookings(userId);
  }

  @override
  Stream<List<Booking>> getAllBookings() {
    return remoteDataSource.getAllBookings();
  }

  @override
  Future<void> updateBookingStatus(String bookingId, String status) async {
    return await remoteDataSource.updateBookingStatus(bookingId, status);
  }
}
