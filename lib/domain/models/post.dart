import 'package:flutter/material.dart';

/// Clean domain model that represents a single feed post.
class Post {
  const Post({
    required this.id,
    required this.username,
    required this.timeAgo,
    required this.caption,
    required this.likes,
    required this.comments,
    required this.gradient,
    required this.mediaIcon,
    this.liked = false,
  });

  final String id;
  final String username;
  final String timeAgo;
  final String caption;
  final int likes;
  final int comments;

  /// Two colors used to paint the post "image" placeholder gradient.
  final List<Color> gradient;

  /// Subtle icon shown in the center of the media placeholder.
  final IconData mediaIcon;
  final bool liked;

  /// Initials rendered inside the avatar (no network images).
  String get initials {
    final parts = username.replaceAll('.', ' ').trim().split(RegExp(r'\s+'));
    final buffer = StringBuffer();
    for (final part in parts.take(2)) {
      if (part.isNotEmpty) buffer.write(part[0].toUpperCase());
    }
    final result = buffer.toString();
    return result.isEmpty ? '?' : result;
  }

  Post copyWith({bool? liked, int? likes}) {
    return Post(
      id: id,
      username: username,
      timeAgo: timeAgo,
      caption: caption,
      likes: likes ?? this.likes,
      comments: comments,
      gradient: gradient,
      mediaIcon: mediaIcon,
      liked: liked ?? this.liked,
    );
  }
}
