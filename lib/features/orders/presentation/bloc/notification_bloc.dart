import 'package:flutter_bloc/flutter_bloc.dart';
import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final List<NotificationItem> _notifications = [
    const NotificationItem(
      title: 'Xush kelibsiz!',
      desc: 'Mehmonxonamizga xush kelibsiz. Biz bilan qolganingizdan mamnunmiz.',
      time: '1 kun oldin',
      type: 'info',
    ),
  ];

  NotificationBloc() : super(NotificationInitial()) {
    on<LoadNotificationsEvent>((event, emit) {
      emit(NotificationLoaded(List.from(_notifications)));
    });

    on<AddNotificationEvent>((event, emit) {
      _notifications.insert(0, event.notification);
      
      // Agar xabarlar soni 5 tadan oshsa, eng eskisini o'chiramiz
      if (_notifications.length > 5) {
        _notifications.removeLast();
      }

      emit(NotificationLoaded(List.from(_notifications)));
    });
  }
}
