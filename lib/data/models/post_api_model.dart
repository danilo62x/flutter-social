import 'package:flutter/material.dart';

import '../../domain/models/post.dart';

/// API-facing model with MANUAL fromJson/toJson mapping.
///
/// Kept intentionally separate from the domain [Post] so the transport shape
/// can evolve without leaking into the UI layer.
class PostApiModel {
  const PostApiModel({
    required this.id,
    required this.username,
    required this.timeAgo,
    required this.caption,
    required this.likes,
    required this.comments,
    required this.gradientStart,
    required this.gradientEnd,
    required this.iconCodePoint,
  });

  final String id;
  final String username;
  final String timeAgo;
  final String caption;
  final int likes;
  final int comments;
  final int gradientStart;
  final int gradientEnd;
  final int iconCodePoint;

  factory PostApiModel.fromJson(Map<String, dynamic> json) {
    return PostApiModel(
      id: json['id'] as String? ?? '',
      username: json['username'] as String? ?? 'unknown',
      timeAgo: json['time_ago'] as String? ?? '',
      caption: json['caption'] as String? ?? '',
      likes: (json['likes'] as num?)?.toInt() ?? 0,
      comments: (json['comments'] as num?)?.toInt() ?? 0,
      gradientStart: (json['gradient_start'] as num?)?.toInt() ?? 0xFFE1306C,
      gradientEnd: (json['gradient_end'] as num?)?.toInt() ?? 0xFFF77737,
      iconCodePoint:
          (json['icon_code_point'] as num?)?.toInt() ?? Icons.image_outlined.codePoint,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'time_ago': timeAgo,
      'caption': caption,
      'likes': likes,
      'comments': comments,
      'gradient_start': gradientStart,
      'gradient_end': gradientEnd,
      'icon_code_point': iconCodePoint,
    };
  }

  /// Maps the transport model into the clean domain model.
  Post toDomain() {
    return Post(
      id: id,
      username: username,
      timeAgo: timeAgo,
      caption: caption,
      likes: likes,
      comments: comments,
      gradient: <Color>[Color(gradientStart), Color(gradientEnd)],
      mediaIcon: _iconFor(iconCodePoint),
    );
  }

  /// Resolves a stored code point to a const [IconData]. Using const icons keeps
  /// the icon tree-shaker happy (avoids non-const IconData construction).
  static IconData _iconFor(int codePoint) {
    switch (codePoint) {
      case 0xe5c8: // matches Icons.wb_twilight family fallback
        return Icons.wb_twilight;
      case 0xe30d:
        return Icons.palette_outlined;
      default:
        return Icons.image_outlined;
    }
  }
}
