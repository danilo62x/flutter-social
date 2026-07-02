import 'package:flutter/foundation.dart';

import '../../../../data/repositories/comment_repository.dart';
import '../../../../domain/models/comment.dart';
import '../../../../domain/models/post.dart';

/// Drives the post detail screen. Seeds the post and a short comment preview
/// synchronously so the screen (and screenshot) has content immediately.
class PostDetailViewModel extends ChangeNotifier {
  PostDetailViewModel(this._post, CommentRepository commentRepository)
      : _preview = commentRepository.seedPreview();

  Post _post;
  final List<Comment> _preview;
  bool _saved = false;

  Post get post => _post;
  List<Comment> get preview => List.unmodifiable(_preview);
  bool get saved => _saved;

  void toggleLike() {
    final nowLiked = !_post.liked;
    _post = _post.copyWith(
      liked: nowLiked,
      likes: _post.likes + (nowLiked ? 1 : -1),
    );
    notifyListeners();
  }

  void toggleSave() {
    _saved = !_saved;
    notifyListeners();
  }
}
