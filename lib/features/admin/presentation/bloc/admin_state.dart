import 'package:equatable/equatable.dart';
import '../../../booking/domain/entities/booking.dart';

abstract class AdminState extends Equatable {
  const AdminState();

  @override
  List<Object> get props => [];
}

class AdminInitial extends AdminState {}

class AdminLoading extends AdminState {}

class AdminBookingsLoaded extends AdminState {
  final List<Booking> bookings;

  const AdminBookingsLoaded(this.bookings);

  @override
  List<Object> get props => [bookings];
}

class AdminError extends AdminState {
  final String message;

  const AdminError(this.message);

  @override
  List<Object> get props => [message];
}
