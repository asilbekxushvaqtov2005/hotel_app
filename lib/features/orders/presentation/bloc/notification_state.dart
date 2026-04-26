import 'package:equatable/equatable.dart';

class NotificationItem extends Equatable {
  final String title;
  final String desc;
  final String time;
  final String type;

  const NotificationItem({
    required this.title,
    required this.desc,
    required this.time,
    required this.type,
  });

  @override
  List<Object?> get props => [title, desc, time, type];
}

abstract class NotificationState extends Equatable {
  const NotificationState();
  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationLoaded extends NotificationState {
  final List<NotificationItem> notifications;
  const NotificationLoaded(this.notifications);
  @override
  List<Object> get props => [notifications];
}
