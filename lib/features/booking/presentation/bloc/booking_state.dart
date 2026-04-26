import 'package:equatable/equatable.dart';
import 'package:hotel_app/features/booking/domain/entities/room.dart';
import 'package:hotel_app/features/booking/domain/entities/booking.dart';

abstract class BookingState extends Equatable {
  const BookingState();

  @override
  List<Object?> get props => [];
}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class AvailableRoomsLoaded extends BookingState {
  final List<Room> rooms;

  const AvailableRoomsLoaded(this.rooms);

  @override
  List<Object?> get props => [rooms];
}

class RoomBookedSuccess extends BookingState {
  final Booking booking;

  const RoomBookedSuccess(this.booking);

  @override
  List<Object?> get props => [booking];
}

class BookingError extends BookingState {
  final String message;

  const BookingError(this.message);

  @override
  List<Object?> get props => [message];
}
