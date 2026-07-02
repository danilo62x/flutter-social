import 'package:flutter/material.dart';

import '../../core/format.dart';

/// The kind of activity a notification represents. Drives both the wording and
/// the trailing widget (a follow button vs. a post thumbnail).
enum NotificationKind { like, comment, follow, mention, tag }

/// A single activity row in the notifications feed.
class NotificationItem {
  const NotificationItem({
    required this.id,
    required this.username,
    required this.kind,
    required this.timeAgo,
    required this.gradient,
    required this.section,
    this.text = '',
    this.postGradient,
    this.postIcon,
    this.isFollowing = false,
  });

  final String id;
  final String username;
  final NotificationKind kind;
  final String timeAgo;

  /// Avatar gradient.
  final List<Color> gradient;

  /// Section bucket used to group rows (e.g. `Hoje`, `Esta semana`).
  final String section;

  /// Extra text (a comment body, a mention, etc.).
  final String text;

  /// Optional post thumbnail gradient for like/comment/tag rows.
  final List<Color>? postGradient;
  final IconData? postIcon;

  /// For follow rows: whether the current user already follows back.
  final bool isFollowing;

  String get initials => initialsOf(username);

  NotificationItem copyWith({bool? isFollowing}) {
    return NotificationItem(
      id: id,
      username: username,
      kind: kind,
      timeAgo: timeAgo,
      gradient: gradient,
      section: section,
      text: text,
      postGradient: postGradient,
      postIcon: postIcon,
      isFollowing: isFollowing ?? this.isFollowing,
    );
  }
}
