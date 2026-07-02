import 'package:flutter/material.dart';

import '../../core/format.dart';

/// A single direct-message conversation preview shown in the inbox list.
class Conversation {
  const Conversation({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.timeAgo,
    required this.gradient,
    this.unread = 0,
    this.online = false,
    this.fromMe = false,
    this.delivered = true,
  });

  final String id;
  final String name;
  final String lastMessage;
  final String timeAgo;

  /// Avatar gradient.
  final List<Color> gradient;

  /// Number of unread messages (0 = fully read).
  final int unread;
  final bool online;

  /// Whether the last message was sent by the current user (prefix `Você: `).
  final bool fromMe;
  final bool delivered;

  bool get hasUnread => unread > 0;

  String get initials => initialsOf(name);
}

/// A friend currently active, shown in the "active now" carousel.
class ActiveFriend {
  const ActiveFriend({
    required this.name,
    required this.gradient,
    this.isSelf = false,
  });

  final String name;
  final List<Color> gradient;
  final bool isSelf;

  String get initials => initialsOf(name);
}
