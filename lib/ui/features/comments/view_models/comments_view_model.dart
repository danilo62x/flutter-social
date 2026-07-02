import 'package:flutter/foundation.dart';

import '../../../../data/repositories/comment_repository.dart';
import '../../../../domain/models/comment.dart';

/// Drives the comments thread. Seeds the full thread synchronously so the list
/// renders immediately.
class CommentsViewModel extends ChangeNotifier {
  CommentsViewModel(CommentRepository repository) : _comments = repository.seed();

  List<Comment> _comments;

  List<Comment> get comments => List.unmodifiable(_comments);

  int get total {
    var count = _comments.length;
    for (final c in _comments) {
      count += c.replies.length;
    }
    return count;
  }

  void toggleLike(String id) {
    _comments = _comments.map((c) {
      if (c.id != id) return c;
      final nowLiked = !c.liked;
      return c.copyWith(
        liked: nowLiked,
        likes: c.likes + (nowLiked ? 1 : -1),
      );
    }).toList(growable: false);
    notifyListeners();
  }
}
