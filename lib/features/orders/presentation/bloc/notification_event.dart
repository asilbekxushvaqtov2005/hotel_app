import 'package:equatable/equatable.dart';
import 'notification_state.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();
  @override
  List<Object> get props => [];
}

class AddNotificationEvent extends NotificationEvent {
  final NotificationItem notification;
  const AddNotificationEvent(this.notification);
  @override
  List<Object> get props => [notification];
}

class LoadNotificationsEvent extends NotificationEvent {}
