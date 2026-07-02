import 'package:flutter/material.dart';

import '../../core/format.dart';

/// A single comment in a post's comment thread. Comments may contain a small
/// list of [replies] so the UI can render a threaded conversation.
class Comment {
  const Comment({
    required this.id,
    required this.username,
    required this.text,
    required this.timeAgo,
    required this.likes,
    required this.gradient,
    this.liked = false,
    this.isAuthor = false,
    this.replies = const <Comment>[],
  });

  final String id;
  final String username;
  final String text;
  final String timeAgo;
  final int likes;

  /// Avatar gradient (no network images — initials on a gradient disc).
  final List<Color> gradient;
  final bool liked;

  /// Whether this comment was written by the post's author (adds a badge).
  final bool isAuthor;
  final List<Comment> replies;

  String get initials => initialsOf(username);

  Comment copyWith({bool? liked, int? likes}) {
    return Comment(
      id: id,
      username: username,
      text: text,
      timeAgo: timeAgo,
      likes: likes ?? this.likes,
      gradient: gradient,
      liked: liked ?? this.liked,
      isAuthor: isAuthor,
      replies: replies,
    );
  }
}
