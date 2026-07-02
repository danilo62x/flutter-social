import 'package:flutter/foundation.dart';

import '../../../../data/repositories/message_repository.dart';
import '../../../../domain/models/conversation.dart';

/// Drives the direct-messages inbox. Seeds conversations and the "active now"
/// row synchronously in the constructor.
class MessagesViewModel extends ChangeNotifier {
  MessagesViewModel(MessageRepository repository)
      : _conversations = repository.seed(),
        _active = repository.seedActive();

  final List<Conversation> _conversations;
  final List<ActiveFriend> _active;

  List<Conversation> get conversations => List.unmodifiable(_conversations);
  List<ActiveFriend> get active => List.unmodifiable(_active);

  int get unreadCount =>
      _conversations.where((c) => c.hasUnread).length;
}
