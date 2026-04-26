import 'package:equatable/equatable.dart';
import '../../../booking/domain/entities/booking.dart';

abstract class AdminEvent extends Equatable {
  const AdminEvent();

  @override
  List<Object> get props => [];
}

class LoadAllBookingsEvent extends AdminEvent {}

class UpdateBookingStatusEvent extends AdminEvent {
  final String bookingId;
  final String status;

  const UpdateBookingStatusEvent({required this.bookingId, required this.status});

  @override
  List<Object> get props => [bookingId, status];
}

class AddNewBookingEvent extends AdminEvent {
  final Booking booking;

  const AddNewBookingEvent(this.booking);

  @override
  List<Object> get props => [booking];
}
