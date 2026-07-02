import 'package:flutter/foundation.dart';

import '../../../../data/repositories/post_repository.dart';
import '../../../../domain/models/post.dart';

/// Drives the [FeedScreen]. Seeds content synchronously in the constructor so
/// the first frame (and the screenshot test) shows real data.
class FeedViewModel extends ChangeNotifier {
  FeedViewModel(this._repository) {
    // Copy into a mutable list so like toggles can update items in place.
    _posts = List<Post>.of(_repository.seed());
    _stories = List<Story>.of(_repository.seedStories());
  }

  final PostRepository _repository;

  late List<Post> _posts;
  late List<Story> _stories;
  bool _loading = false;

  List<Post> get posts => List.unmodifiable(_posts);
  List<Story> get stories => List.unmodifiable(_stories);
  bool get loading => _loading;

  /// Toggles the like state (and count) for a given post.
  void toggleLike(String id) {
    final index = _posts.indexWhere((p) => p.id == id);
    if (index == -1) return;
    final current = _posts[index];
    final nowLiked = !current.liked;
    _posts[index] = current.copyWith(
      liked: nowLiked,
      likes: current.likes + (nowLiked ? 1 : -1),
    );
    notifyListeners();
  }

  /// Real async refresh via the repository/service. Falls back to the seed on
  /// error so the UI never ends up empty.
  Future<void> refresh() async {
    _loading = true;
    notifyListeners();
    try {
      _posts = List<Post>.of(await _repository.fetch());
    } catch (_) {
      _posts = List<Post>.of(_repository.seed());
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
