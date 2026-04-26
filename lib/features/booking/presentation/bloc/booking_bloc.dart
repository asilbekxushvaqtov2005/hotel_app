import 'package:flutter_bloc/flutter_bloc.dart';
import 'booking_event.dart';
import 'booking_state.dart';
import '../../domain/repositories/booking_repository.dart';
import '../../domain/usecases/book_room_usecase.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final BookingRepository repository;
  final BookRoomUseCase bookRoomUseCase;

  BookingBloc({
    required this.repository,
    required this.bookRoomUseCase,
  }) : super(BookingInitial()) {
    
    on<LoadAvailableRoomsEvent>((event, emit) async {
      emit(BookingLoading());
      try {
        final rooms = await repository.getAvailableRooms(event.checkIn, event.checkOut);
        emit(AvailableRoomsLoaded(rooms));
      } catch (e) {
        emit(BookingError('Xonalarni yuklashda xatolik yuz berdi: ${e.toString()}'));
      }
    });

    on<BookRoomEvent>((event, emit) async {
      emit(BookingLoading());
      try {
        final booking = await bookRoomUseCase.call(
          roomId: event.roomId,
          userId: event.userId,
          checkIn: event.checkIn,
          checkOut: event.checkOut,
        );
        emit(RoomBookedSuccess(booking));
      } catch (e) {
        emit(BookingError('Bron qilishda xatolik: ${e.toString()}'));
      }
    });
  }
}
