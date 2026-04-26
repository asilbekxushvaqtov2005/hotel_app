import 'package:equatable/equatable.dart';
import '../../../../domain/entities/room.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object?> get props => [];
}

class LoadAvailableRoomsEvent extends BookingEvent {
  final DateTime checkIn;
  final DateTime checkOut;

  const LoadAvailableRoomsEvent({required this.checkIn, required this.checkOut});

  @override
  List<Object?> get props => [checkIn, checkOut];
}

class BookRoomEvent extends BookingEvent {
  final String roomId;
  final String userId;
  final DateTime checkIn;
  final DateTime checkOut;

  const BookRoomEvent({
    required this.roomId,
    required this.userId,
    required this.checkIn,
    required this.checkOut,
  });

  @override
  List<Object?> get props => [roomId, userId, checkIn, checkOut];
}
