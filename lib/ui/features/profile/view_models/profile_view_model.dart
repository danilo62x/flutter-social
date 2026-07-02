import 'package:flutter/foundation.dart';

import '../../../../data/repositories/post_repository.dart';
import '../../../../data/repositories/profile_repository.dart';
import '../../../../domain/models/post.dart';
import '../../../../domain/models/profile.dart';

/// Drives the profile screen. Seeds the profile header and the grid of the
/// user's posts synchronously in the constructor.
class ProfileViewModel extends ChangeNotifier {
  ProfileViewModel(ProfileRepository profileRepository, PostRepository postRepository)
      : _profile = profileRepository.seed(),
        _posts = postRepository.seedProfilePosts();

  Profile _profile;
  final List<Post> _posts;

  Profile get profile => _profile;
  List<Post> get posts => List.unmodifiable(_posts);

  void toggleFollow() {
    final nowFollowing = !_profile.isFollowing;
    _profile = _profile.copyWith(
      isFollowing: nowFollowing,
      followers: _profile.followers + (nowFollowing ? 1 : -1),
    );
    notifyListeners();
  }
}
