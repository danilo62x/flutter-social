import 'package:flutter/material.dart';

import '../../domain/models/comment.dart';

/// API-facing model for a comment, with MANUAL fromJson/toJson mapping.
///
/// Mirrors the [Comment] domain model but keeps the transport shape isolated
/// from the UI layer (same split as [PostApiModel]).
class CommentApiModel {
  const CommentApiModel({
    required this.id,
    required this.username,
    required this.text,
    required this.timeAgo,
    required this.likes,
    required this.gradientStart,
    required this.gradientEnd,
    this.liked = false,
    this.isAuthor = false,
  });

  final String id;
  final String username;
  final String text;
  final String timeAgo;
  final int likes;
  final int gradientStart;
  final int gradientEnd;
  final bool liked;
  final bool isAuthor;

  factory CommentApiModel.fromJson(Map<String, dynamic> json) {
    return CommentApiModel(
      id: json['id'] as String? ?? '',
      username: json['username'] as String? ?? 'unknown',
      text: json['text'] as String? ?? '',
      timeAgo: json['time_ago'] as String? ?? '',
      likes: (json['likes'] as num?)?.toInt() ?? 0,
      gradientStart: (json['gradient_start'] as num?)?.toInt() ?? 0xFFE1306C,
      gradientEnd: (json['gradient_end'] as num?)?.toInt() ?? 0xFFF77737,
      liked: json['liked'] as bool? ?? false,
      isAuthor: json['is_author'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'text': text,
      'time_ago': timeAgo,
      'likes': likes,
      'gradient_start': gradientStart,
      'gradient_end': gradientEnd,
      'liked': liked,
      'is_author': isAuthor,
    };
  }

  /// Maps the transport model into the clean domain model.
  Comment toDomain() {
    return Comment(
      id: id,
      username: username,
      text: text,
      timeAgo: timeAgo,
      likes: likes,
      gradient: <Color>[Color(gradientStart), Color(gradientEnd)],
      liked: liked,
      isAuthor: isAuthor,
    );
  }
}
