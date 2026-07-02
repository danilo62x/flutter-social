import 'package:flutter/material.dart';

/// Whether an explore tile is a single photo, a reel (video) or a carousel.
enum TileKind { photo, reel, carousel }

/// A discovery tile shown in the Explore grid. Rendered as a gradient with an
/// icon and an optional overlay (play + views for reels, a stack for carousels).
class ExploreTile {
  const ExploreTile({
    required this.id,
    required this.gradient,
    required this.icon,
    this.kind = TileKind.photo,
    this.views = 0,
    this.tall = false,
  });

  final String id;
  final List<Color> gradient;
  final IconData icon;
  final TileKind kind;

  /// View count shown on reels.
  final int views;

  /// When true the tile spans two rows (used for the featured tile).
  final bool tall;
}
