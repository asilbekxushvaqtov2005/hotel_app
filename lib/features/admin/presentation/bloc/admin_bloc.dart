import 'package:flutter_bloc/flutter_bloc.dart';
import 'admin_event.dart';
import 'admin_state.dart';
import '../../../booking/domain/repositories/booking_repository.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final BookingRepository repository;

  AdminBloc({required this.repository}) : super(AdminInitial()) {
    on<LoadAllBookingsEvent>((event, emit) async {
      emit(AdminLoading());
      await emit.forEach(
        repository.getAllBookings(),
        onData: (bookings) => AdminBookingsLoaded(bookings),
        onError: (error, stackTrace) => AdminError(error.toString()),
      );
    });

    on<UpdateBookingStatusEvent>((event, emit) async {
      try {
        await repository.updateBookingStatus(event.bookingId, event.status);
      } catch (e) {
        emit(AdminError('Statusni yangilashda xatolik: ${e.toString()}'));
      }
    });

    on<AddNewBookingEvent>((event, emit) async {
      try {
        // Repository orqali yangi bron/buyurtma qo'shish
        await repository.bookRoom(
          roomId: event.booking.roomId,
          userId: event.booking.userId,
          checkIn: event.booking.checkIn,
          checkOut: event.booking.checkOut,
        );
      } catch (e) {
        emit(AdminError('Xatolik: ${e.toString()}'));
      }
    });
  }
}
