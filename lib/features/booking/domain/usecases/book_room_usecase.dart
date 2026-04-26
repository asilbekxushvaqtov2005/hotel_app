import '../entities/booking.dart';
import '../repositories/booking_repository.dart';

class BookRoomUseCase {
  final BookingRepository repository;

  BookRoomUseCase(this.repository);

  Future<Booking> call({
    required String roomId,
    required String userId,
    required DateTime checkIn,
    required DateTime checkOut,
  }) async {
    // Calling the repository which will handle the transaction logic
    return await repository.bookRoom(
      roomId: roomId,
      userId: userId,
      checkIn: checkIn,
      checkOut: checkOut,
    );
  }
}
