import 'package:flutter/material.dart';

import '../../core/format.dart';

/// A saved story highlight shown as a labelled gradient circle on the profile.
class ProfileHighlight {
  const ProfileHighlight({
    required this.label,
    required this.gradient,
    required this.icon,
  });

  final String label;
  final List<Color> gradient;
  final IconData icon;
}

/// Clean domain model for a user profile header.
class Profile {
  const Profile({
    required this.name,
    required this.username,
    required this.bio,
    required this.posts,
    required this.followers,
    required this.following,
    required this.gradient,
    this.category = '',
    this.link = '',
    this.isVerified = false,
    this.isFollowing = false,
    this.highlights = const <ProfileHighlight>[],
  });

  final String name;
  final String username;
  final String bio;
  final int posts;
  final int followers;
  final int following;

  /// Avatar gradient (initials rendered on top).
  final List<Color> gradient;
  final String category;
  final String link;
  final bool isVerified;
  final bool isFollowing;
  final List<ProfileHighlight> highlights;

  String get initials => initialsOf(name);

  Profile copyWith({bool? isFollowing, int? followers}) {
    return Profile(
      name: name,
      username: username,
      bio: bio,
      posts: posts,
      followers: followers ?? this.followers,
      following: following,
      gradient: gradient,
      category: category,
      link: link,
      isVerified: isVerified,
      isFollowing: isFollowing ?? this.isFollowing,
      highlights: highlights,
    );
  }
}
