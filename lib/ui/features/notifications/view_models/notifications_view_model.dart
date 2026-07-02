import 'package:flutter/foundation.dart';

import '../../../../data/repositories/notification_repository.dart';
import '../../../../domain/models/notification_item.dart';

/// Drives the notifications screen. Seeds the list synchronously and exposes it
/// grouped by section (Hoje / Esta semana ...) preserving order.
class NotificationsViewModel extends ChangeNotifier {
  NotificationsViewModel(NotificationRepository repository)
      : _items = repository.seed();

  List<NotificationItem> _items;

  List<NotificationItem> get items => List.unmodifiable(_items);

  /// Section label -> notifications, preserving insertion order.
  Map<String, List<NotificationItem>> get grouped {
    final map = <String, List<NotificationItem>>{};
    for (final item in _items) {
      map.putIfAbsent(item.section, () => <NotificationItem>[]).add(item);
    }
    return map;
  }

  void toggleFollow(String id) {
    _items = _items
        .map((n) => n.id == id ? n.copyWith(isFollowing: !n.isFollowing) : n)
        .toList(growable: false);
    notifyListeners();
  }
}
